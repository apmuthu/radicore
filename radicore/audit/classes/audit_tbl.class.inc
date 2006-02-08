<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************
require_once 'std.table.class.inc';
class audit_tbl extends Default_Table
{
    // member variables
    var $trn_array;         // audit transaction data

    // ****************************************************************************
    function audit_tbl ()
    {
        // save directory name of current script
        $this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->dbname      = 'audit';
        $this->tablename   = 'audit_tbl';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

        // there is absolutely NO logging of the audit database
        // (otherwise there would be an endless loop)
        $this->audit_logging = false;

    } // audit_tbl

    // ****************************************************************************
    function auditDelete ($dbname, $tablename, $fieldspec, $where, $oldarray)
    // add a record to the audit trail for a DELETE.
    {
        $newarray = array();

        // use the general-purpose method
        $this->auditWrite($dbname, $tablename, $fieldspec, $where, $newarray, $oldarray);

        return;

    } // auditDelete

    // ****************************************************************************
    function auditDeleteSelection ($dbname, $tablename, $fieldspec, $selection)
    // add a record to the audit trail for a DELETE of a selection of records.
    {
        $newarray = array();
        $oldarray = array();

        // turn $where string into an array of row identifiers
        $where_array = where2indexedArray($selection);

        // add separate audit record for each row
        foreach ($where_array as $row => $rowdata) {
            $where = array2where($rowdata);
            // add record details to audit database
            $this->auditWrite($dbname, $tablename, $fieldspec, $where, $newarray, $oldarray);
        } // foreach

        return;

    } // auditDeleteSelection

    // ****************************************************************************
    function auditInsert ($dbname, $tablename, $fieldspec, $where, $newarray)
    // add a record to the audit trail for an INSERT.
    {
        $oldarray = array();

        // use the general-purpose method
        $this->auditWrite($dbname, $tablename, $fieldspec, $where, $newarray, $oldarray);

        return;

    } // auditInsert

    // ****************************************************************************
    function auditUpdate ($dbname, $tablename, $fieldspec, $where, $newarray, $oldarray)
    // add a record to the audit trail for an UPDATE.
    {
        // use the general-purpose method
        $this->auditWrite($dbname, $tablename, $fieldspec, $where, $newarray, $oldarray);

        return;

    } // auditUpdate

    // ****************************************************************************
    function auditUpdateSelection ($dbname, $tablename, $fieldspec, $selection, $replace)
    // add a record to the audit trail for an UPDATE of a selection of records.
    {
        //DebugBreak();
        $oldarray = where2array($selection);

        // turn $replace string into an array of 'item=value' pairs
        $newarray = where2array($replace);

        // turn $where string into an array of row identifiers
        $where_array = splitWhereByRow($selection);

        // add separate audit record for each row
        foreach ($where_array as $row => $rowdata) {
            $where = $rowdata;
            // add record details to audit database
            $this->auditWrite($dbname, $tablename, $fieldspec, $where, $newarray, $oldarray);
        } // foreach

        return;

    } // auditUpdateSelection

    // ****************************************************************************
    function auditWrite ($dbname, $tablename, $fieldspec, $where, $newarray, $oldarray)
    // add a record to the audit trail for an INSERT, UPDATE or DELETE.
    {
        //DebugBreak();
        $this->errors = array();

        if (!isset($_SESSION['session_number'])) {
            // first time only, get details from audit_ssn
            require_once 'audit_ssn.class.inc';
            $ssn_obj =& singleton::getInstance('audit_ssn');
            $ssn_data = $ssn_obj->insertRecord(array());
            if ($ssn_obj->errors) {
                $this->errors = $ssn_obj->getErrors();
            	return;
            } // if
            $_SESSION['session_number'] = $ssn_data['session_id'];
        } else {
            $ssn_data['session_id'] = $_SESSION['session_number'];
        } // if

        if (empty($this->trn_array)) {
            // first time only, get details from audit_trn
            require_once 'audit_trn.class.inc';
            $trn_obj =& singleton::getInstance('audit_trn');
            $this->trn_array = $trn_obj->insertRecord($ssn_data);
            if ($trn_obj->errors) {
                $this->errors = $trn_obj->getErrors();
                return;
            } // if
        } // if

        $fieldarray  = $this->trn_array;
        $session_id  = $fieldarray['session_id'];
        $tran_seq_no = $fieldarray['tran_seq_no'];

        // obtain the next value for table_seq_no
        $select = "SELECT max(table_seq_no) FROM $this->tablename WHERE session_id='$session_id' AND tran_seq_no=$tran_seq_no";
        $count = $this->getCount($select);
        $fieldarray['table_seq_no'] = $count + 1;

        $fieldarray['base_name']  = $dbname;
        $fieldarray['table_name'] = $tablename;

        $pkey_string = trim($where, '( )');
        $fieldarray['pkey'] = addslashes($pkey_string);

        // add this record to the database
        $fieldarray = $this->_dml_insertRecord ($fieldarray);
        if ($this->errors) {
        	return;
        } // if

        foreach ($fieldspec as $field => $spec) {
        	if (isset($spec['noaudit'])) {
        	    // 'no audit logging' switch is set, so disguise this field's value
        	    if (isset($oldarray[$field])) {
        	    	$oldarray[$field] = '**********';
        	    } // if
        	    if (isset($newarray[$field])) {
        	    	$newarray[$field] = '**********';
        	    } // if
            } // if
        } // foreach

        if (!empty($newarray)) {
            // look for new fields with empty/null values
            foreach ($newarray as $item => $value) {
                if (strlen($value) == 0) {
                    if (!array_key_exists($item, $oldarray)) {
                        // value does not exist in $oldarray, so remove from $newarray
                        unset ($newarray[$item]);
                    } // if
                } else {
                    // remove slashes (escape characters) from $newarray
                    $newarray[$item] = stripslashes($newarray[$item]);
                } // if
            } // foreach
            // remove entry from $oldarray which does not exist in $newarray
            foreach ($oldarray as $item => $value) {
                if (!array_key_exists($item, $newarray)) {
                    unset ($oldarray[$item]);
                } // if
            } // foreach
        } // if

        $table_seq_no = $fieldarray['table_seq_no'];
        $fieldarray   = array();
        $ix           = 0;

        foreach ($oldarray as $field_id => $old_value) {
            $ix++;
        	$fieldarray[$ix]['session_id']   = $session_id;
        	$fieldarray[$ix]['tran_seq_no']  = $tran_seq_no;
        	$fieldarray[$ix]['table_seq_no'] = $table_seq_no;
        	$fieldarray[$ix]['field_id']     = $field_id;
        	$fieldarray[$ix]['old_value']    = $old_value;
        	if (array_key_exists($field_id, $newarray)) {
        		$fieldarray[$ix]['new_value'] = $newarray[$field_id];
        		// remove matched entry from $newarray
        		unset($newarray[$field_id]);
        	} else {
        	    $fieldarray[$ix]['new_value'] = '';
        	} // if
        } // foreach

        // process any unmatched details remaining in $newarray
        foreach ($newarray as $field_id => $new_value) {
            $ix++;
        	$fieldarray[$ix]['session_id']   = $session_id;
        	$fieldarray[$ix]['tran_seq_no']  = $tran_seq_no;
        	$fieldarray[$ix]['table_seq_no'] = $table_seq_no;
        	$fieldarray[$ix]['field_id']     = $field_id;
        	$fieldarray[$ix]['old_value']    = '';
        	$fieldarray[$ix]['new_value']    = $new_value;
        } // foreach

        // add all these records to the database
        require_once 'audit_fld.class.inc';
        $fld_obj =& singleton::getInstance('audit_fld');

        $fieldarray = $fld_obj->insertMultiple($fieldarray);
        $this->errors = $fld_obj->getErrors();

        // switch from AUDIT back to original database name
        $this->selectDB($dbname);

        return;

    } // auditWrite

    // ****************************************************************************
    function close ()
    // close this transaction
    {
        $this->trn_array = array();

        return TRUE;

    } // close

    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        if ($GLOBALS['mode'] == 'search') {
            // add extra (non-database) fields to search screen
            $this->fieldspec['date_from'] = array('type' => 'date',
                                                  'size' => 12);
            $this->fieldspec['date_to']   = array('type' => 'date',
                                                  'size' => 12);
            $this->fieldspec['time_from'] = array('type' => 'time',
                                                  'size' => 8);
            $this->fieldspec['time_to']   = array('type' => 'time',
                                                  'size' => 8);
            $this->fieldspec['user_id']   = array('type' => 'string',
                                                  'size' => 16);
            $this->fieldspec['task_id']   = array('type' => 'string',
                                                  'size' => 32);
            // remove 'noedit' setting from other fields
            unset($this->fieldspec['base_name']['noedit']);
            unset($this->fieldspec['table_name']['noedit']);
            unset($this->fieldspec['pkey']['noedit']);
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_getExtraData($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        //DebugBreak();
        if ($GLOBALS['mode'] == 'search') {
            if (isset($_POST['clear'])) {
                // do nothing
            } elseif (empty($fieldarray)) {
                require_once 'std.datevalidation.class.inc';
                $dateobj =& singleton::getInstance('date_class');
                // set default values in screen
                $fieldarray['user_id']   = $_SESSION['logon_user_id'];
                $fieldarray['date_from'] = $dateobj->getExternalDate(getTimeStamp('date'));
            } // if
        } // if

        return $fieldarray;

    } // _cm_getExtraData

    // ***************************************************************************
    function _cm_initialise ($where, $selection)
    // perform any initialisation for the current task.
    {
        if ($GLOBALS['mode'] == 'list') {
            // ignore $where, use $search instead
            $this->allow_empty_where = TRUE;
        } // if

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    {
        //DebugBreak();
        if ($GLOBALS['mode'] == 'list') {
            // do not bother checking for complete primary key
            $this->checkPrimaryKey = FALSE;
        } // if

        if (empty($this->sql_search)) return $where;

        // convert from string to an associative array
        $fieldarray = where2array($this->sql_search);

        // merge the '_from' and '_to' fields into a single field
        if (isset($fieldarray['date_from'])) {
            if (isset($fieldarray['date_to'])) {
                $fieldarray['audit_trn.date'] = "BETWEEN '{$fieldarray['date_from']}' AND '{$fieldarray['date_to']}'";
            } else {
                $fieldarray['audit_trn.date'] = $fieldarray['date_from'];
            } // if
            unset($fieldarray['date_from']);
            unset($fieldarray['date_to']);
        } // if

        if (isset($fieldarray['date_to'])) {
            $fieldarray['audit_trn.date'] = $fieldarray['date_to'];
            unset($fieldarray['date_to']);
        } // if

        if (isset($fieldarray['time_from'])) {
            if (isset($fieldarray['time_to'])) {
                $fieldarray['audit_trn.time'] = "BETWEEN '{$fieldarray['time_from']}' AND '{$fieldarray['time_to']}'";
            } else {
                $fieldarray['audit_trn.time'] = $fieldarray['time_from'];
            } // if
            unset($fieldarray['time_from']);
            unset($fieldarray['time_to']);
        } // if

        if (isset($fieldarray['time_to'])) {
            $fieldarray['audit_trn.time'] = $fieldarray['time_to'];
            unset($fieldarray['time_to']);
        } // if

        $this->sql_search = array2where($fieldarray);

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>