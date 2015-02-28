<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'dict_column.class.inc';
class dict_column_s01 extends dict_column
{
    // ****************************************************************************
    // this subclass is used by dict_column(import)
    // ****************************************************************************
    var $delete_array = array();    // items to be deleted
    var $update_array = array();    // items to be updated
    var $target_dbname;             // dbname of entry being processed
    var $target_tablename;          // tablename of entry being processed

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
                $lock_array[] = 'dict_database';
                $lock_array[] = 'dict_table_key';
                $lock_array[] = 'dict_relationship';
                $lock_array[] = 'dict_related_column';
                if ($this->target_dbname == $this->dbname) {
                	if (in_array($this->target_tablename, $lock_array)) {
                	    // already there, so ignore it
                	} else {
                	    $lock_array[] = $this->target_tablename;
                	} // if
                } else {
                    $lock_array[] = $this->target_dbname .'.' .$this->target_tablename;
                } // if
                break;
            case 'update':
                $lock_array[] = $this->tablename;
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
        // extract database and table names
        if (!is_string(key($fieldarray))) {
            $fieldarray = $fieldarray[0];  // use first entry from indexed array
        } // if

        $dbname_dict =& $fieldarray['database_id'];
        $tablename   =& $fieldarray['table_id'];

        if (empty($dbname_dict) OR empty($tablename)) {
            // 'Database and/or Table id is missing - please check selection'
            $this->errors[] = getLanguageText('e0019');
            return $fieldarray;
        } // if

        // save these for _cm_getDatabaseLock() method
        $this->target_dbname    = $dbname_dict;
        $this->target_tablename = $tablename;

        // get any existing dictionary data for this table
        $this->sql_orderby      = 'column_seq';
        $dict_data  = $this->getData("database_id='$dbname_dict' AND table_id='$tablename'");

        // construct a smaller array of column names and sequence numbers
        $dict_data_cols = array();
        foreach ($dict_data as $row => $rowdata) {
        	$dict_data_cols[$rowdata['column_id']] = $row;
        } // foreach

        $insert_array       = array();
        $this->delete_array = array();
        $this->update_array = array();

        // obtain a list of current column definitions from the database server
        $db_data = $this->_ddl_showColumns($dbname_dict, $tablename);
        if (empty($db_data)) {
            $this->errors[] = getlanguageText('e0028',$tablename);
            return $insert_array;
        } // if

        // construct a smaller array of column names
        $db_data_cols = array();
        foreach ($db_data as $row => $rowdata) {
        	$db_data_cols[strtolower($rowdata['column_id'])] = $row;
        	// start sequence numbers from 1, not 0
        	$db_data[$row]['column_seq'] = $row+1;
        } // foreach

        // construct array of static (common) data
        $static['database_id'] = $dbname_dict;
        $static['table_id']    = $tablename;

        // compare contents of dictionary and the physical database
        foreach ($dict_data_cols as $columnid => $ix) {
            if (array_key_exists($columnid, $db_data_cols)) {
                // entry to be updated
                $db_ix               = $db_data_cols[$columnid];
                $col_type            = $db_data[$db_ix]['col_type'];
                $col_type_native     = $db_data[$db_ix]['col_type_native'];
                $col_type_old        = $dict_data[$ix]['col_type'];
                //$col_type_native_old = $dict_data[$ix]['col_type_native'];
                $col_maxsize_old     = $dict_data[$ix]['col_maxsize'];
                $user_size_old       = $dict_data[$ix]['user_size'];
                $update = array_merge($dict_data[$ix], $db_data[$db_ix]);

                // check for fields which may have a choice of types in a comma-delimited list
                if (strpos($col_type_native, ',')) {
                	$type_array = explode(',', $col_type_native);
                	if (in_array($col_type_old, $type_array)) {
                	    // existing col_type is in this list, so keep it
                        $update['col_type'] = $col_type_old;
                	} else {
                	    // not there, so default to first entry in array
                	    $update['col_type'] = $type_array[0];
                	} // if
                } // if

                if (!preg_match('/boolean/i', $col_type_native)) {
                    $update['is_boolean']    = null;
                    $update['boolean_true']  = null;
                    $update['boolean_false'] = null;
                } // if

                if (isset($update['col_maxsize'])) {
                    if ($update['col_maxsize'] <> $col_maxsize_old) {
                        // size has changed
                        if ($col_maxsize_old == $user_size_old) {
                            // replace old size with new size
                            $update['user_size'] = $update['col_maxsize'];
                        } else {
                            // user size was different
                            if ($user_size_old > $update['col_maxsize']) {
                                // old value is now too large, so it must be replaced
                                $update['user_size'] = $update['col_maxsize'];
                            } // if
                        } // if
                    } // if
                } // if

                // check for updates to column min/max values
                if (is_null($update['user_minvalue']) OR $update['user_minvalue'] < $update['col_minvalue']) {
                    $update['user_minvalue'] = $update['col_minvalue'];
                } // if
                if (is_null($update['user_maxvalue']) OR $update['user_maxvalue'] > $update['col_maxvalue']) {
                    $update['user_maxvalue'] = $update['col_maxvalue'];
                } // if
                // if size has changed then update min/max values
                if ($dict_data[$ix]['col_maxsize'] != $db_data[$db_data_cols[$columnid]]['col_maxsize']) {
                	$update['user_minvalue'] = $update['col_minvalue'];
                    $update['user_maxvalue'] = $update['col_maxvalue'];
                } // if

                if (!empty($dict_data[$ix]['col_comment'])) {
                    // do not overwrite previous comment
                    unset($update['col_comment']);
                } // if

                if (is_True($update['col_null'])) {
                	$update['is_required'] = 'N';
                } else {
                    $update['is_required'] = 'Y';
                } // if

                // transfer to member variable for processing in a later method
        	    $this->update_array[] = $update;
                unset($db_data[$db_data_cols[$columnid]]);
                unset($db_data_cols[$columnid]);
        	} else {
                // entry to be deleted
                $this->delete_array[] = $dict_data[$ix];
                unset($dict_data[$ix]);
        	} // if
        } // foreach

        // anything left in $db_data array is a new record which is to be inserted
        foreach ($db_data as $row => $columndata) {
        	// insert details of new column/field
            $seq = $row+1;
            $insert_array[$seq]['column_desc']   = ucwords(strtolower(str_replace('_', ' ', $columndata['column_id'])));
            if (isset($columndata['user_size'])) {
                $insert_array[$seq]['user_size'] = $columndata['user_size'];
            } else {
                $insert_array[$seq]['user_size'] = $columndata['col_maxsize'];
            } // if
            $insert_array[$seq]['user_minvalue'] = $columndata['col_minvalue'];
            $insert_array[$seq]['user_maxvalue'] = $columndata['col_maxvalue'];
            $insert_array[$seq]['is_required']   = $columndata['col_null'];
            if (is_True($columndata['col_null'])) {
            	$insert_array[$seq]['is_required'] = 'N';
            } else {
                $insert_array[$seq]['is_required'] = 'Y';
            } // if
            if (strpos($columndata['col_type'], ',')) {
                // field has a choice of types, so default to first entry in list
            	$type_array = explode(',', $columndata['col_type']);
            	$columndata['col_type'] = $type_array[0];
            } // if
            $insert_array[$seq] = array_merge($insert_array[$seq], $static, $columndata);
        } // foreach

        return $insert_array;

    } // _cm_getInitialDataMultiple

    // ****************************************************************************
    function _cm_post_insertMultiple ($fieldarray)
    // perform custom processing after multiple database records are inserted.
    {
        //DebugBreak();
        $errors = array();
        foreach ($this->errors as $row => $rowdata) {
            foreach ($rowdata as $field => $msg) {
                $errors[] = '[' .$fieldarray[$row]['column_id'] .'] ' .$field .': ' .$msg;
            } // foreach
        } // foreach

        // new records have been inserted - now process any deletions and/or updates
        if (!empty($this->delete_array)) {
            $array = $this->deleteMultiple($this->delete_array);
            foreach ($this->errors as $row => $rowdata) {
                foreach ($rowdata as $field => $msg) {
                    $errors[] = '[' .$this->delete_array[$row]['column_id'] .'] ' .$field .': ' .$msg;
                } // foreach
            } // foreach
        } // if

        if (!empty($this->update_array)) {
            $array = $this->updateMultiple($this->update_array);
            foreach ($this->errors as $row => $rowdata) {
                foreach ($rowdata as $field => $msg) {
                    $errors[] = '[' .$this->update_array[$row]['column_id'] .'] ' .$field .': ' .$msg;
                } // foreach
            } // foreach
        } // if

        $this->errors = $errors;

        if (empty($this->errors)) {
            // now import the keys for the current table
            $keyobj =& RDCsingleton::getInstance('dict_table_key');

            $array = $keyobj->getInitialDataMultiple($this->where);
            $array = $keyobj->insertMultiple($array);
            if ($keyobj->getErrors()) {
                $errors = $keyobj->getErrors();
                foreach ($errors as $row => $error) {
            	    $this->errors[] = 'From DICT_TABLE_KEY: ' .$error;
                } // foreach
            } // if

            // extract any messages from $keyobj
            $this->messages = array_merge($this->messages, $keyobj->getMessages());
        } // if

        return $fieldarray;

    } // _cm_post_insertMultiple

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record is inserted.
    {
        // this is here to replace the method defined in the parent class

        return $fieldarray;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_pre_insertRecord ($fieldarray)
    // perform custom processing before database record is inserted.
    {
        // this is here to replace the method defined in the parent class

        return $fieldarray;

    } // _cm_pre_insertRecord

// ****************************************************************************
} // end class
// ****************************************************************************

?>
