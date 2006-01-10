<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'dict_column.class.inc';
class dict_column_s01 extends dict_column
{
    // ****************************************************************************
    // this subclass is used by dict_related_column.multi2
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
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {
        //DebugBreak();
        if (isset($fieldarray['database_id']) and isset($fieldarray['table_id'])) {
            // continue
        } else {
            // 'Database and/or Table id is missing - please check selection'
            $this->errors[] = getLanguageText('e0019');
            return $fieldarray;
        } // if

        // get any existing data for this table
        $dbname    = $fieldarray['database_id'];
        $tablename = $fieldarray['table_id'];

        // save these for _cm_getDatabaseLock () method
        $this->target_dbname    = $dbname;
        $this->target_tablename = $tablename;

        $this->sql_orderby = 'column_seq';
        $old_data  = $this->getData("database_id='$dbname' AND table_id='$tablename'");

        // construct a smaller array of column names
        $old_data_cols = array();
        foreach ($old_data as $row => $rowdata) {
        	$old_data_cols[$rowdata['column_id']] = $row;
        } // foreach

        // obtain a list of current column definitions from the database engine
        $fieldarray = array();
        $db_data = $this->_ddl_showColumns($dbname, $tablename);

        // construct a smaller array of column names
        $db_data_cols = array();
        foreach ($db_data as $row => $rowdata) {
        	$db_data_cols[$rowdata['column_id']] = $row;
        } // foreach

        // construct array of static (common) data
        $static['database_id'] = $dbname;
        $static['table_id']    = $tablename;

        // compare contents of dictionary and the physical database
        $this->delete_array = array();
        $this->update_array = array();
        foreach ($old_data_cols as $columnid => $ix) {
            if (array_key_exists($columnid, $db_data_cols)) {
                $seq = $db_data_cols[$columnid]+1;
                // entry to be updated
                $update = array_merge($old_data[$ix], $db_data[$db_data_cols[$columnid]]);
                $update['column_seq'] = $seq;
                // check for updates to boolean field
                if (eregi('(char|tinyint)', $update['col_type'])) {
                    if ($update['user_size'] == 1) {
                        if (is_True($update['is_boolean'])) {
                            // this was boolean before, so reset it
                            $update['col_type'] = 'boolean';
                        } // if
                    } // if
                } // if
                // check for updates to column min/max values
                if ($update['user_size'] > $update['col_maxsize']) {
                    $update['user_size'] = $update['col_maxsize'];
                } elseif (strlen($update['user_size']) == 0) {
                    $update['user_size'] = $update['col_maxsize'];
                } // if
                if ($update['user_minvalue'] < $update['col_minvalue']) {
                    $update['user_minvalue'] = $update['col_minvalue'];
                } elseif (strlen($update['user_minvalue']) == 0) {
                    $update['user_minvalue'] = $update['col_minvalue'];
                } // if
                if ($update['user_maxvalue'] > $update['col_maxvalue']) {
                    $update['user_maxvalue'] = $update['col_maxvalue'];
                } elseif (strlen($update['user_maxvalue']) == 0) {
                    $update['user_maxvalue'] = $update['col_maxvalue'];
                } // if

                // transfer to member variable for processing in a later method
        	    $this->update_array[$seq] = $update;
                unset($db_data[$db_data_cols[$columnid]]);
                unset($db_data_cols[$columnid]);
        	} else {
                // entry to be deleted
                $seq = $ix+1;
        	    $this->delete_array[$seq] = $old_data[$ix];
                unset($old_data[$ix]);
        	} // if
        } // foreach

        // anything left in $db_data array is to be inserted
        foreach ($db_data as $row => $columndata) {
        	// insert details of new database
            $seq = $row+1;
            $fieldarray[$seq]['column_seq']    = $seq;
            $fieldarray[$seq]['column_desc']   = $columndata['column_id'];
            $fieldarray[$seq]['user_size']     = $columndata['col_maxsize'];
            $fieldarray[$seq]['user_minvalue'] = $columndata['col_minvalue'];
            $fieldarray[$seq]['user_maxvalue'] = $columndata['col_maxvalue'];
            $fieldarray[$seq] = array_merge($fieldarray[$seq], $static, $columndata);
        } // foreach

        $this->ignore_empty_fields = true;

        return $fieldarray;

    } // _cm_getInitialData

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

        // new records have been inserted - now process any deletions and/por updates
        if (!empty($this->delete_array)) {
            $array = $this->deleteMultiple($this->delete_array);
            foreach ($this->errors as $row => $rowdata) {
                foreach ($rowdata as $field => $msg) {
                    $errors[] = 'Seq: ' .$row .', ' .$field .': ' .$msg;
                } // foreach
            } // foreach
        } // if

        if (!empty($this->update_array)) {
            $array = $this->updateMultiple($this->update_array);
            foreach ($this->errors as $row => $rowdata) {
                foreach ($rowdata as $field => $msg) {
                    $errors[] = 'Seq: ' .$row .', ' .$field .': ' .$msg;
                } // foreach
            } // foreach
        } // if

        $this->errors = $errors;

        // now import the keys for the current table
        static $keyobj;
        if (!is_object($keyobj)) {
            require_once 'dict_table_key.class.inc';
            $keyobj =& singleton::getInstance('dict_table_key');
        } // if

        $array = $keyobj->getInitialData($this->where);
        $array = $keyobj->insertMultiple($array);
        if ($keyobj->getErrors()) {
            $errors = $keyobj->getErrors();
            foreach ($errors as $row => $error) {
            	$this->errors[] = 'From DICT_TABLE_KEY: ' .$error;
            } // foreach
        } // if

        // extract any messages from $keyobj
        $this->messages = array_merge($this->messages, $keyobj->getMessages());

        return $fieldarray;

    } // _cm_post_insertMultiple

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record is inserted.
    {
        //DebugBreak();
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
