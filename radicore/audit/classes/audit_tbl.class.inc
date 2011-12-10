<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2011 by Radicore Software Limited <http://www.radicore.org>
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
        $dbprefix = $GLOBALS['dbprefix'];  // save

        $newarray = array();

        // use the general-purpose method
        $this->auditWrite($dbname, $tablename, $fieldspec, $where, $newarray, $oldarray);

        $GLOBALS['dbprefix'] = $dbprefix;  // restore

        return;

    } // auditDelete

    // ****************************************************************************
    function auditDeleteSelection ($dbname, $tablename, $fieldspec, $selection)
    // add a record to the audit trail for a DELETE of a selection of records.
    {
        $dbprefix = $GLOBALS['dbprefix'];  // save

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

        $GLOBALS['dbprefix'] = $dbprefix;  // restore

        return;

    } // auditDeleteSelection

    // ****************************************************************************
    function auditInsert ($dbname, $tablename, $fieldspec, $where, $newarray)
    // add a record to the audit trail for an INSERT.
    {
        $dbprefix = $GLOBALS['dbprefix'];  // save

        $oldarray = array();

        // use the general-purpose method
        $this->auditWrite($dbname, $tablename, $fieldspec, $where, $newarray, $oldarray);

        $GLOBALS['dbprefix'] = $dbprefix;  // restore

        return;

    } // auditInsert

    // ****************************************************************************
    function auditUpdate ($dbname, $tablename, $fieldspec, $where, $newarray, $oldarray)
    // add a record to the audit trail for an UPDATE.
    {
        $dbprefix = $GLOBALS['dbprefix'];  // save

        // use the general-purpose method
        $this->auditWrite($dbname, $tablename, $fieldspec, $where, $newarray, $oldarray);

        $GLOBALS['dbprefix'] = $dbprefix;  // restore

        return;

    } // auditUpdate

    // ****************************************************************************
    function auditUpdateSelection ($dbname, $tablename, $fieldspec, $selection, $replace)
    // add a record to the audit trail for an UPDATE of a selection of records.
    {
        $dbprefix = $GLOBALS['dbprefix'];  // save

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

        $GLOBALS['dbprefix'] = $dbprefix;  // restore

        return;

    } // auditUpdateSelection

    // ****************************************************************************
    function auditWrite ($dbname, $tablename, $fieldspec, $where, $newarray, $oldarray)
    // add a record to the audit trail for an INSERT, UPDATE or DELETE.
    {
        $this->errors = array();

        if (!isset($_SESSION['session_number'])) {
            // first time only, get details from audit_ssn
            $ssn_obj =& RDCsingleton::getInstance('audit_ssn');
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
            $trn_obj =& RDCsingleton::getInstance('audit_trn');
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
        $fieldarray['pkey'] = $pkey_string;

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
        	} elseif (isset($spec['type']) AND $spec['type'] == 'blob') {
        	    // do not include BLOB fields in the audit trail
        	    if (!empty($oldarray[$field])) {
        	    	$oldarray[$field] = '<BLOB>';
        	    } // if
        	    if (!empty($newarray[$field])) {
        	    	$newarray[$field] = '<BLOB>';
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
        $fld_obj =& RDCsingleton::getInstance('audit_fld');

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
            // do not include these fields in the search string
            unset($this->fieldspec['session_id']);
            unset($this->fieldspec['table_seq_no']);
            unset($this->fieldspec['tran_seq_no']);
        } // if

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_formatData ($fieldarray, &$css_array)
    // perform custom formatting before values are shown to the user.
    {
        if (isset($fieldarray['trn_date'])) {
            $dateobj =& RDCsingleton::getInstance('date_class');
        	$fieldarray['trn_date'] = $dateobj->getExternalDate($fieldarray['trn_date']);
        } // if

        return $fieldarray;

    } // _cm_formatData

    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    {
        $pattern_id = getPatternId();
        if (preg_match('/^(add)/i', $pattern_id)) {
        	// ignore contents of selection
        } else {
            if (!empty($selection)) {
            	$where     = $selection;
            	$selection = null;
            } // if
        } // if

        if ($GLOBALS['mode'] == 'list') {
            // ignore $where, use $search instead
            $this->allow_empty_where = TRUE;
        } // if

        if (!empty($where)) {
            // do not override previous settings
        } else {
            if (isset($GLOBALS['return_from']) AND isset($GLOBALS['return_action'])) {
            	if ($GLOBALS['return_from'] == 'audit_dtl(search)' AND $GLOBALS['return_action'] == 'quit') {
                    // no current selection, and search was cancelled, so quit instead of retrieving all occurrences
                	scriptPrevious();
                } // if
            } // if
        	if ($GLOBALS['mode'] == 'search') {
        	    if (isset($_SESSION['search'][$this->tablename])) {
        	        // previous search criteria exists, so don't change it
        	    } else {
                    // set initial values in screen
                    $where = "user_id='" .$_SESSION['logon_user_id'] ."' AND "
                            ."date_from='" .getTimeStamp('date') ."'";
        	    } // if
            } // if
        } // if

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        if ($GLOBALS['mode'] == 'list') {
            // do not bother checking for complete primary key
            $this->checkPrimaryKey = FALSE;
        } // if

        if (!empty($this->sql_search)) {
            $search_array = where2array($this->sql_search, false, false);

            // deal with values which have ranges
            if (!empty($search_array['date_from']) OR !empty($search_array['date_to'])) {
                $search_array['trn_date'] = rangeFromTo($search_array['date_from'], $search_array['date_to'], true);
                unset($search_array['date_from']);
                unset($search_array['date_to']);
            } // if

            if (!empty($search_array['time_from']) OR !empty($search_array['time_to'])) {
            	$search_array['trn_time'] = rangeFromTo($search_array['time_from'], $search_array['time_to']);
                unset($search_array['time_from']);
                unset($search_array['time_to']);
            } // if

            $this->sql_search = array2where($search_array);
        } // if

        return $where;

    } // _cm_pre_getData

// ****************************************************************************
} // end class
// ****************************************************************************

?>
