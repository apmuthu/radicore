<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

class Default_Table
{
    // member variables
    var $allow_empty_where = false;     // switch to allow an empty $where string in STD.LIST2.INC
    var $audit_logging = false;         // yes/no switch
    var $checkPrimaryKey = false;       // yes/no switch
    var $child_relations = array();     // child relationship specifications (optional)
    var $dbname;                        // database name
    var $dirname;                       // directory name of current script
    var $errors = array();              // array of errors
    var $expanded;                      // list of tree nodes which have been expanded
    var $fieldarray;                    // array of row/field data
    var $fieldspec = array();           // field specifications (see class constructor)
    var $field_access;                  // see setFieldAccess()
    var $ignore_empty_fields = false;   // YES/NO switch (see getInitialData() method)
    var $inner_table;                   // used in an outer-link-inner relationship
    var $instruction;                   // instruction to be passed to previous script
    var $is_link_table = FALSE;         // used in method sqlAssembleWhere (many-link-many relationship)
    var $lastpage;                      // last available page number in current query
    var $lookup_data = array();         // array of lookup data (for dropdowns, radio groups)
    var $messages = array();            // array of messages
    var $numrows;                       // number of rows retrieved
    var $outer_table;                   // used in an outer-link-inner relationship
    var $pageno;                        // requested page number
    var $parent_relations = array();    // parent relationship specifications (optional)
    var $primary_key = array();         // column(s) which form the primary key
    var $row_locks;                     // FALSE, SH=shared, EX=exclusive
    var $rows_per_page = 0;             // page size for multi-row forms
    var $scrollarray;                   // array for internal scrolling
    var $scrollindex;                   // index to current item in scrollarray
    var $selectall = false;             // TRUE or FALSE (refer to setAction() method)
    var $skip_getdata = false;          // YES/NO switch
    var $skip_validation = false;       // YES/NO switch
    var $tablename;                     // table name (internal)
    var $via_updateMultiple = false;    // YES/NO switch - see updateMultiple() method
    var $unique_keys = array();         // unique key specifications (optional)
    var $updatearray;                   // array that will be passed to the database for updating
    var $wf_case_id;                    // workflow case id
    var $wf_workitem_id;                // workflow workitem id
    var $xref_item;                     // used in sqlAssembleWhere() in many-to-many relationships
    var $xsl_params = array();          // optional parameters to be pased to XSL transformation

    // this defines the default database engine (may be changed in sub-classes)
    var $dbms_engine = 'mysql';

    // the following are used to construct an SQL query
    var $where;                         // passed from parent form
    var $selectarray;                   // additional selection criteria
    var $sql_select;
    var $sql_from;
    var $sql_where;                     // additional selection criteria
    var $sql_groupby;
    var $sql_having;
    var $sql_orderby;                   // sort field
    var $sql_orderby_seq;               // 'asc' or 'desc'
    var $default_orderby = null;        // default, may be overridden by $sql_orderby
    var $sql_search;                    // optional search criteria from a search screen
    var $sql_search_table;              // tablename qualifier for optional search criteria
    var $sql_sort_table;                // tablename qualifier for optional sort criteria

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function Default_Table ()
    {
        // save directory name of current script
        //$this->dirname   = dirname(__file__);

        $this->tablename = 'default';
        $this->dbname    = 'default';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // Default_Table

    // ****************************************************************************
    function cascadeDelete ($where)
    // Parent record is being deleted, so remove associated records from this table.
    {
        //DebugBreak();
        $errors = array();

        // retrieve all records which match criteria in $where
        $fieldarray = $this->getData_raw($where);
        $errors = array_merge($errors, $this->errors);

        // now delete them one at a time
        foreach ($fieldarray as $rowdata) {
            $rowdata = $this->deleteRecord($rowdata);
            foreach ($this->errors as $error) {
                $errors[] = "$this->tablename - $error";
            } // foreach
        } // foreach

        if (count($errors) > 0) {
            $this->errors = $errors;
            return false;
        } // if

        return true;

    } // cascadeDelete

    // ****************************************************************************
    function cascadeNullify ($update_array, $where)
    // Parent record is being deleted, so nullify foreign keys in associated records in this table.
    {
        //DebugBreak();
        $errors = array();

        // retrieve all records which match criteria in $where
        $fieldarray = $this->getData_raw($where);
        $errors = array_merge($errors, $this->errors);

        // now update them one at a time
        foreach ($fieldarray as $rowdata) {
            $rowdata = array_merge($rowdata, $update_array);
            $rowdata = $this->updateRecord($rowdata);
            foreach ($this->errors as $error) {
                $errors[] = "$this->tablename - $error";
            } // foreach
        } // foreach

        if (count($errors) > 0) {
            $this->errors = $errors;
            return false;
        } // if

        return true;

    } // cascadeNullify

    // ****************************************************************************
    function checkWorkflow ($where)
    // check workflow system to see if this task is a pending workitem.
    {
        $this->errors = array();

        if ($this->dbname != 'workflow') {
            // find out if this task/context is a workitem within a workflow instance
            $this->_examineWorkflowInstance($where);
        } // if

        return $this->errors;

    } // checkWorkflow

    // ****************************************************************************
    function clearEditableData ($fieldarray)
    // initialise the internal $scrollarray.
    {
        $fieldspec = $this->fieldspec;

        foreach ($fieldarray as $field => $value) {
        	if (array_key_exists($field, $fieldspec)) {
        		if (array_key_exists('noedit', $fieldspec[$field])) {
        		    // field is not editable, so leave it alone
        	    } else {
        	        // field is editable, so remove current value
        	        $fieldarray[$field] = NULL;
        	    } // if
        	} // if
        } // foreach

        return $fieldarray;

    } // clearEditableData

    // ****************************************************************************
    function clearScrollArray ()
    // initialise the internal $scrollarray.
    {
        $this->scrollarray = array();

        $this->scrollindex = 0;
        $this->pageno      = 0;
        $this->numrows     = 0;
        $this->lastpage    = 0;

        return;

    } // clearScrollArray

    // ****************************************************************************
    function commit ()
    // commit this transaction
    {
        // if this task is a pending workitem then update it
        $errors = $this->updateWorkflow($this->fieldarray);

        $DML =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);
        if ($errors) {
            $result = $DML->rollback($this->dbname);
        } else {
            if (!$result = $DML->commit($this->dbname)) {
                $errors[] = getLanguageText('sys0009'); // 'Commit failed'
            } // if
        } // if

        $GLOBALS['transaction_has_started'] = FALSE;

        return $errors;

    } // commit

    // ****************************************************************************
    function deleteMultiple ($fieldarray)
    // delete multiple records using data in $fieldarray.
    {
        $errors = array();
        $count  = 0;

        // delete each row one by one
        foreach ($fieldarray as $row) {
            $row = $this->deleteRecord($row);
            if (!empty($this->errors)) {
                // accumulate all errors
                $errors = array_merge($errors, $this->errors);
            } else {
                $count++;
            } // if
        } // foreach

        // return a count of affected rows
        $this->messages[] = getLanguageText('sys0004', $count, strtoupper($this->tablename)); // '$count records were deleted from $tablename'

        $this->errors  = $errors;
        $this->numrows = $count;

        return $fieldarray;

    } // deleteMultiple

    // ****************************************************************************
    function deleteRecord ($fieldarray)
    // delete the record specified in $fieldarray.
    {
        //DebugBreak();
        $this->errors = array();   // initialise

        if (is_string($fieldarray)) {
            // convert from string to array
            $fieldarray = where2indexedArray($fieldarray);
            $fieldarray = indexed2assoc($fieldarray);
        } // if

        // strip any operators from the value portion of the array
        $fieldarray = stripOperators($fieldarray);

        // check that full primary key has been supplied
        if ($result = isPkeyComplete($fieldarray, $this->getPkeyNames())) {
            $this->errors = $result;
        } // if

        // get field specifications for this database table
        $fieldspec = $this->fieldspec;

        // remove any non-database fields from input array
        foreach ($fieldarray as $field => $fieldvalue) {
            // check that $field exists in $fieldspec array
            if (!array_key_exists($field, $fieldspec)) {
                // it does not (like the SUBMIT button, for example), so remove it
                unset ($fieldarray[$field]);
            } // if
        } // foreach

        // perform any custom pre-delete processing
        if (empty($this->errors)) {
            $fieldarray = $this->_cm_pre_deleteRecord($fieldarray);
        } // if

        // delete any tables related to the specified record
        if (empty($this->errors)) {
            $this->deleteRelations($fieldarray);
        } // if

        // delete the specified record
        if (empty($this->errors)) {
            $this->_dml_deleteRecord($fieldarray);
        } // if

        // perform any custom post-delete processing
        if (empty($this->errors)) {
            $fieldarray = $this->_cm_post_deleteRecord($fieldarray);
        } // if

        return $fieldarray;

    } // deleteRecord

    // ****************************************************************************
    function deleteRelations ($fieldarray)
    // delete any child records whch are linked to the current record.
    {
        //DebugBreak();
        $this->errors = array();

        if (empty($this->child_relations)) {
            return;
        } // if

        // process contents of $child_relations array
        foreach ($this->child_relations as $reldata) {
            $tblchild = $reldata['child'];
            switch ($reldata['type']){
                case 'nullify':
                case 'NUL':
                    // set foreign key(s) to null
                    $where = NULL;
                    $update_array = array();
                    foreach ($reldata['fields'] as $fldparent => $fldchild) {
                        if (strlen($fldchild) < 1) {
                        	$this->errors[] = getLanguageText('sys0110', strtoupper($tblchild)); // 'Name of child field missing in relationship with $tblchild';
                        	break;
                        } // if
                        $where  .= "$fldchild='" .addslashes($fieldarray[$fldparent]) ."' AND ";
                        $update_array[$fldchild] = NULL;
                    } // foreach
                    $where  = rtrim($where, ' AND');

                    // instantiate an object for this table
                    if (array_key_exists('subsys_dir', $reldata)) {
                        $dir = $_SERVER['DOCUMENT_ROOT'] .getParentDIR() .'/' .$reldata['subsys_dir'] .'/';
                    } else {
                        $dir = NULL;
                    } // if
                    require_once $dir ."classes/$tblchild.class.inc";
                    $childobject = new $tblchild;
                    // now use this object to delete child records
                    if (!$childobject->cascadeNullify($update_array, $where)) {
                        $this->errors = array_merge($childobject->getErrors(), $this->errors);
                    } // if
                    unset($childobject);
                    break;

                case 'delete':
                case 'DEL':
                case 'cascade':
                case 'CAS':
                    // delete all related rows
                    $where = NULL;
                    foreach ($reldata['fields'] as $fldparent => $fldchild) {
                        if (strlen($fldchild) < 1) {
                        	$this->errors[] = getLanguageText('sys0110', strtoupper($tblchild)); // 'Name of child field missing in relationship with $tblchild';
                        	break;
                        } // if
                        $where .= "$fldchild='" .addslashes($fieldarray[$fldparent]) ."' AND ";
                    } // foreach
                    $where = rtrim($where, ' AND');

                    // instantiate an object for this table
                    if (array_key_exists('subsys_dir', $reldata)) {
                        $dir = $_SERVER['DOCUMENT_ROOT'] .getParentDIR() .'/' .$reldata['subsys_dir'] .'/';
                    } else {
                        $dir = NULL;
                    } // if
                    require_once $dir ."classes/$tblchild.class.inc";
                    $childobject = new $tblchild;
                    // check for 'order by' clause
                    if (isset($reldata['orderby'])) {
                        $childobject->default_orderby = $reldata['orderby'];
                    } // if
                    // now use this object to delete child records
                    if (!$childobject->cascadeDelete($where)) {
                        $this->errors = array_merge($childobject->getErrors(), $this->errors);
                    } // if
                    unset($childobject);
                    break;

                case 'restricted':
                case 'RES':
                    break;
                default:
                    $this->errors[] = getLanguageText('sys0010', $reldata['type']); // 'Unknown relation type: $type'
            } // switch
        } // foreach

        return;

    } // deleteRelations

    // ****************************************************************************
    function deleteScrollItem ($index)
    // delete the specified item from $scrollarray, then return the details of the
    // next available item.
    {
        //DebugBreak();
        if ($index > count($this->scrollarray)) {
            // index is too high, so do not delete
            $index = count($this->scrollarray);
        } elseif ($index < 1) {
            // index is too low, so do not delete
            $index = 1;
        } else {
            // index is valid, so remove indicated item
            unset($this->scrollarray[$index]);
            // resequence the array after removing this item
            $array[0] = 'dummy';
            foreach ($this->scrollarray as $entry) {
            	$array[] = $entry;
            } // foreach
            unset($array[0]);
            $this->scrollarray = $array;
            if ($index > count($this->scrollarray)) {
                // index is too high, so do not delete
                $index = count($this->scrollarray);
            } // if
        } // if

        // replace $where with details from the next available entry in scrollarray
        if (is_array($this->scrollarray[$index])) {
            $where = array2where($this->scrollarray[$index]);
        } else {
            $where = $this->scrollarray[$index];
        } // if

        // set values to be used by scrolling logic
        $this->scrollindex = $index;
        $this->pageno      = $index;
        $this->lastpage    = count($this->scrollarray);

        return $where;

    } // deletetScrollItem

    // ****************************************************************************
    function deleteSelection ($selection)
    // delete/update a selection of records in one operation.
    {
        //DebugBreak();
        $this->errors = array();

        // call custom method for specific processig
        $msg = $this->_cm_deleteSelection($selection);

        return $msg;

    } // deleteSelection

    // ****************************************************************************
    function eraseRecord ($fieldarray)
    // delete the record, and ALL its children, specified in $fieldarray.
    {
        //DebugBreak();
        $this->errors = array();   // initialise

        if (is_string($fieldarray)) {
            // convert from string to array
            $fieldarray = where2indexedArray($fieldarray);
            $fieldarray = indexed2assoc($fieldarray);
        } // if

        // strip any operators from the value portion of the array
        $fieldarray = stripOperators($fieldarray);

        // check that full primary key has been supplied
        if ($result = isPkeyComplete($fieldarray, $this->getPkeyNames())) {
            $this->errors = $result;
        } // if

        if (empty($this->errors)) {
            // get field specifications for this database table
            $fieldspec = $this->fieldspec;

            // remove any non-database fields from input array
            foreach ($fieldarray as $field => $fieldvalue) {
                // check that $field exists in $fieldspec array
                if (!array_key_exists($field, $fieldspec)) {
                    // it does not (like the SUBMIT button, for example), so remove it
                    unset ($fieldarray[$field]);
                } // if
            } // foreach
        } // if

        // perform any custom pre-erase processing
        if (empty($this->errors)) {
            $fieldarray = $this->_cm_pre_eraseRecord($fieldarray);
        } // if

        // delete any tables related to the specified record
        if (empty($this->errors)) {
            $this->eraseRelations($fieldarray);
        } // if

        // delete the specified record
        if (empty($this->errors)) {
            $this->_dml_deleteRecord($fieldarray);
        } // if

        // perform any custom post-delete processing
        if (empty($this->errors)) {
            $fieldarray = $this->_cm_post_eraseRecord($fieldarray);
        } // if

        return $fieldarray;

    } // eraseRecord

    // ****************************************************************************
    function eraseRelations ($fieldarray)
    // erase any child records whch are linked to the current record.
    // this is done by treating every relationship type as CASCADE DELETE
    {
        //DebugBreak();
        $this->errors = array();

        if (empty($this->child_relations)) {
            return;
        } // if

        // process contents of $child_relations array
        foreach ($this->child_relations as $reldata) {
            $tblchild = $reldata['child'];
            if (array_key_exists('subsys_dir', $reldata)) {
                // do not erase from a database in another subsystem
            } else {
                switch ($reldata['type']){
                case 'nullify':
                case 'NUL':
                    // set foreign key(s) to null
                    $where = NULL;
                    $update_array = array();
                    foreach ($reldata['fields'] as $fldparent => $fldchild) {
                        if (strlen($fldchild) < 1) {
                        	$this->errors[] = getLanguageText('sys0110', strtoupper($tblchild)); // 'Name of child field missing in relationship with $tblchild';
                        	break;
                        } // if
                        $where  .= "$fldchild='" .addslashes($fieldarray[$fldparent]) ."' AND ";
                        $update_array[$fldchild] = NULL;
                    } // foreach
                    $where  = rtrim($where, ' AND');

                    // instantiate an object for this table
                    if (array_key_exists('subsys_dir', $reldata)) {
                        $dir = $_SERVER['DOCUMENT_ROOT'] .getParentDIR() .'/' .$reldata['subsys_dir'] .'/';
                    } else {
                        $dir = NULL;
                    } // if
                    require_once $dir ."classes/$tblchild.class.inc";
                    $childobject = new $tblchild;
                    // now use this object to delete child records
                    if (!$childobject->cascadeNullify($update_array, $where)) {
                        $this->errors = array_merge($childobject->getErrors(), $this->errors);
                    } // if
                    unset($childobject);
                    break;

                default:
                	// erase all related rows
                    $where = NULL;
                    foreach ($reldata['fields'] as $fldparent => $fldchild) {
                        if (strlen($fldchild) < 1) {
                            // 'Name of child field missing in relationship with $tblchild'
                        	$this->errors[] = getLanguageText('sys0110', strtoupper($tblchild));
                        	break;
                        } // if
                        $where .= "$fldchild='" .addslashes($fieldarray[$fldparent]) ."' AND ";
                    } // foreach
                    $where = rtrim($where, ' AND');

                    // instantiate an object for this table
                    if (array_key_exists('subsys_dir', $reldata)) {
                        $dir = $_SERVER['DOCUMENT_ROOT'] .getParentDIR() .'/' .$reldata['subsys_dir'] .'/';
                    } else {
                        $dir = NULL;
                    } // if
                    if (!class_exists($tblchild)) {
                    	require_once $dir ."classes/$tblchild.class.inc";
                    } // if
                    $childobject = new $tblchild;
                    // check for 'order by' clause
                    if (isset($reldata['orderby'])) {
                        $childobject->default_orderby = $reldata['orderby'];
                    } // if
                    // pass down the current audit logging switch
                    $childobject->audit_logging = $this->audit_logging;
                    $childdata = $childobject->getData_raw($where);
                    foreach ($childdata as $childrow) {
                    	// now use this object to delete each child record one at a time
                        $childobject->eraseRecord($childrow);
                        if ($childobject->getErrors()) {
                            $this->errors = array_merge($childobject->getErrors(), $this->errors);
                            return FALSE;
                        } // if
                    } // foreach
                    unset($childobject);
                } // switch
            } // if

        } // foreach

        return;

    } // eraseRelations

    // ****************************************************************************
    function fetchRow ($result)
    // Fetch the next row from a result set created in getData_batch() method.
    {
        $this->errors = array();

        $DML =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $array = $DML->fetchRow($this->dbname, $result);

        return $array;

    } // fetchRow

    // ****************************************************************************
    function formatData ($fieldarray)
    // format values retrieved from the database before they are shown to the user.
    // (such as changing dates from 'CCYY-MM-DD' to 'dd Mmm CCYY'
    {
        //DebugBreak();
        static $dateobj;

        if (!isset($dateobj)) {
            require_once 'std.datevalidation.class.inc';
            $dateobj =& singleton::getInstance('date_class');
        } // if

        foreach ($fieldarray as $fieldname => $fieldvalue) {
            // only deal with fields defined in $fieldspec
            if (isset($this->fieldspec[$fieldname])) {
                // get specifications for current field
                $fieldspec = $this->fieldspec[$fieldname];
                if (!isset($fieldspec['type'])) {
                    $fieldspec['type'] = 'string';  // set default type
                } // if

                switch (strtolower($fieldspec['type'])) {
                	case 'string':
                        // escape any suspect characters in string fields
                        $fieldarray[$fieldname] = stripslashes($fieldvalue);
            		    break;
                	case 'boolean':
                		// set boolean fields to either TRUE or FALSE
                        if (is_True($fieldvalue)) {
                            $fieldarray[$fieldname] = $fieldspec['true'];
                        } else {
                            $fieldarray[$fieldname] = $fieldspec['false'];
                        } // if
                		break;
                	case 'date':
                		if (isset($fieldspec['infinityisnull']) and $fieldvalue == '9999-12-31') {
                            // this date is shown to the user as empty
                            $fieldarray[$fieldname] = '';
                        } else {
                            if ($GLOBALS['mode'] == 'search' and strpos($fieldvalue, '%')) {
                            	// this is already in LIKE format for a seach screen. so leave it alone
                            	// (apart from removing trailing '%' which will be replaced later)
                            	$fieldarray[$fieldname] = rtrim($fieldvalue, '%');
                            } else {
                                // convert date from internal to external format
                                $fieldarray[$fieldname] = $dateobj->getExternalDate($fieldvalue);
                            } // if
                        } // if
                		break;
                	case 'datetime':
                	case 'timestamp':
                		if (isset($fieldspec['infinityisnull']) and substr($fieldvalue, 0, 10) == '9999-12-31') {
                            // this date is shown to the user as empty
                            $fieldarray[$fieldname] = '';
                        } else {
                            if (!empty($fieldvalue)) {
                                // convert date from internal to external format
                                // look for last space as a delimiter between date and time portions
                                $pos = strrpos($fieldvalue, ' ');
                                // now split the input into its two portions
                                $date = substr($fieldvalue, 0, $pos);
                                $time = substr($fieldvalue, $pos);
                                if ($date = $dateobj->getExternalDate($date)) {
                                    $fieldarray[$fieldname] = trim($date) .' ' .trim($time);
                                } else {
                                    // date is empty, so return empty time as well
                                    $fieldarray[$fieldname] = '';
                                } // if
                            } // if
                        } // if
                		break;
                	case 'time':
                		if (isset($fieldspec['size']) and $fieldspec['size'] == 5) {
                            // exclude the seconds portion of the time
                            $fieldarray[$fieldname] = substr($fieldarray[$fieldname], 0, 5);
                        } // if
                		break;
                	case 'float':
                    case 'double':
                    case 'real':
                		if (!empty($fieldvalue)) {
                            if (is_numeric($fieldvalue)) {
                                $float   = sprintf('%f', $fieldvalue);
                                $integer = sprintf('%d', $fieldvalue);
                                if ($float == $integer) {
                                    // this is a whole number, so remove all decimals
                                    $fieldarray[$fieldname] = $integer;
                                } else {
                                    // remove trailing zeroes from the decimal portion
                                    $float = rtrim($float,'0');
                                    // remove trailing decimal point from the decimal portion
                                    $float = rtrim($float,'.');
                                    $fieldarray[$fieldname] = $float;
                                } // if
                            } // if
                        } // if
                		break;
                	case 'decimal':
                	case 'numeric':
                	    if (isset($fieldspec['scale'])) {
                	       $decimal_places = $fieldspec['scale'];
                	   } else {
                	       $decimal_places = 0;
                	   } // if
                	   if ($fieldvalue == 0 AND isset($fieldspec['blank_when_zero'])) {
                	       $fieldvalue = ''; // value is zero, so display blank
                	   } else {
                    	   $locale = localeconv();
                    	   $decimal_point  = $locale['decimal_point'];
                    	   $thousands_sep  = $locale['thousands_sep'];
                    	   if ($thousands_sep == chr(160)) {
                    	       // change non-breaking space into ordinary space
                               $thousands_sep = chr(32);
                           } // if
                    	   $fieldvalue = number_format($fieldvalue, $decimal_places, $decimal_point, $thousands_sep);
                	   } // if
                	   // put back into array
                       $fieldarray[$fieldname] = $fieldvalue;
                	   break;
                	default:
                		;
                } // switch

                if (isset($fieldspec['password'])) {
                    if (isset($fieldspec['hash'])) {
                        if (ereg('sha1|md5', $fieldspec['hash'])) {
                            // for this hash type do not output anything
                            $fieldarray[$fieldname] = '';
                        } // if
                    } // if
                } // if

            } // if
        } // foreach

        // perform any custom formatting
        $fieldarray = $this->_cm_formatData($fieldarray);

        return $fieldarray;

    } // formatData

    // ****************************************************************************
    function getClassName ()
    // return the name of this class, but without any numeric suffix.
    // Example: table 'mnu_tran' may have subtypes (aliases) of 'mnu_tran_s01'
    // and 'mnu_tran_jnr'. These will return the following:
    // 'mnu_tran'     -> 'mnu_tran'
    // 'mnu_tran_s01' -> 'mnu_tran'
    // 'mnu_tran_jnr' -> 'mnu_tran_jnr'
    {
        // look for a suffix of '_snn'
        $pattern = '/([_])'         // underscore
                 . '([Ss])'         // upper or lowercase 'S'
                 . '([0-9]{2}$)/';  // 2 digits

        if (preg_match($pattern, get_class($this), $regs)) {
            // classname contains suffix, so remove it
            $name = strtolower(get_class($this));
            $name = substr($name, 0, strlen($name)-4);
            return $name;
        } else {
            // no suffix, so return classname 'as-is'
            return strtolower(get_class($this));
        } // if

    } // getClassName

    // ****************************************************************************
    function getCount ($where)
    // get count of records that satisfy selection criteria in $where.
    {
		if (strlen(trim($where)) > 0) {
		    $count = $this->_dml_getCount($where);
			return $count;
		} else {
			return 0;
		} // if

    } // getCount

    // ****************************************************************************
    function getData ($where)
    // get data from this table using optional 'where' criteria.
    // this is formatted before being displayed to the user.
    {
        $this->errors = array();    // initialise

        $this->where = $where;      // save

        if (is_null($this->pageno)) {
        	$this->pageno = 1;      //default
        } // if

        // convert $where from string to an associative array
        $where_array = where2array($where, $this->pageno);

        // perform any custom pre-retrieve processing
        $where = $this->_cm_pre_getData($where, $where_array);
        if ($this->errors) return;

        if ($this->where != $where) {
            // $where has bee modified
        	$this->where = $where;
        	// convert $where from string to an associative array
            $where_array = where2array($where, $this->pageno);
        } // if

        if ($this->checkPrimaryKey) {
            $this->errors = isPkeycomplete($where_array, $this->getPkeyNames());
            if ($this->errors) return;
        } // if

        // assemble the $where string from its component parts
        $where_str = $this->sqlAssembleWhere($where, $where_array);
        $this->checkPrimaryKey = false;

        if ($this->skip_getdata) {
            // use data already loaded in
        	$data_raw = $this->fieldarray;
        	$this->numrows = count($data_raw);
        	if (empty($this->scrollarray)) {
                // set record/page counts from contents of $this->fieldarray
                if ($this->numrows == 0) {
                    $this->lastpage = 0;
                    $this->pageno   = 0;
                } else {
                    if ($this->rows_per_page > 0) {
                    	$this->lastpage = ceil($this->numrows/$this->rows_per_page);
                    } else {
                        $this->lastpage = $this->numrows;
                    } // if
                    if ($this->pageno < 1) {
                    	$this->pageno = 1;
                    } elseif ($this->pageno > $this->lastpage) {
                    	$this->pageno = $this->lastpage;
                    } // if
                } // if
        	} // if

        } else {
            $this->fieldarray = array();
            // get the data from the database
            $data_raw = $this->_dml_getData($where_str);
        } // if

        // clear 'nodisplay' option which may have been by previous iteration
        foreach ($this->fieldspec as $field => $spec) {
        	if (array_key_exists('autoinsert', $spec) or array_key_exists('autoupdate', $spec)) {
        	    unset($this->fieldspec[$field]['nodisplay']);
        	} // if
        } // foreach

        $entry = getEntryPoint($this);
        if (strtolower($entry) == 'getdata') {
            if (isset($this->instruction)) {
                $data_raw = $this->_processInstruction($data_raw);
            } // if

            // perform any custom post-retrieve processing
            $data_raw = $this->_cm_post_getData($data_raw, $where);
        } // if

        // perform any formatting on the raw data
        $this->fieldarray = array();
        foreach ($data_raw as $rowdata) {
            if ($this->selectall) {
                // switch has been set (see setAction() method), so mark this row as 'selected'
                //$rowdata['selected'] = true;
            } // if
            $this->fieldarray[] = $this->formatData($rowdata);
        } // foreach

        return $this->fieldarray;

    } // getData

    // ****************************************************************************
    function getData_batch ($where)
    // Issue an SQL query and return result, not an array of data.
    // Individual rows will be returned using the fetchRow() method.
    {
        $this->errors = array();

        $DML =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $DML->sql_from         = $this->sql_from;
        $DML->sql_groupby      = $this->sql_groupby;
        $DML->sql_having       = $this->sql_having;
        $DML->sql_orderby      = $this->getOrderBy();
        $DML->sql_orderby_seq  = $this->getOrderBySeq();
        $DML->sql_select       = $this->sql_select;
        $DML->sql_where        = $this->sql_where;

        $result = $DML->getData_batch($this->dbname, $this->tablename, $where);

        $this->numrows  = $DML->getNumRows();

        return $result;

    } // getData_batch

    // ****************************************************************************
    function getData_raw ($where)
    // get data from this table using optional 'where' criteria.
    // this is returned raw (as read from the database with any formatting).
    {
        $this->errors = array();

        $data_raw = $this->_dml_getData($where);

        return $data_raw;

    } // getData_raw

    // ****************************************************************************
    function getDBname ()
    // return the database name for this table.
    {

        return strtolower($this->dbname);

    } // getDBname

    // ****************************************************************************
    function getEnum ($fieldname)
    // get the contents of an ENUM field and return it as an array.
    {

        $array = $this->_dml_getEnum($fieldname);

        return $array;

    } // getEnum

    // ****************************************************************************
    function getErrors ()
    // return array of error messages
    {

        if (is_string($this->errors)) {
            // convert string into an array
            $errors[] = $this->errors;
            $this->errors = $errors;
        } // if

        return $this->errors;

    } // getErrors

    // ****************************************************************************
    function getExpanded ()
    // get array of tree nodes which have been expanded
    {
        $expanded = $this->expanded;
        $this->expanded = array();

        return $expanded;

    } // getExpanded

    // ****************************************************************************
    function getExtraData ($input)
    // get additional data for this table, such as lookup lists.
    {
        // $input may be an array or a string
        if (is_array($input)) {
            if (version_compare(phpversion(), '4.4.1', '=')) {
                foreach ($input as $key => $value) {   // fix for version 4.4.1
                    $input[$key] = $value;             // fix for version 4.4.1
                } // foreach                           // fix for version 4.4.1
            } // if
            if (!empty($input) and !is_string(key($input))) {
                // indexed by row, so use it as-is
                $fieldarray = $input;
                $key = key($input);
            } else {
                if (empty($input)) {
                    $fieldarray = array();
                } else {
                    // set input array to row zero
                    $fieldarray[0] = $input;
                } // if
                $key = 0;
            } // if
            // convert into string after removing non-Pkey fields
            $where = array2where ($fieldarray[$key], $this->getPkeyNames());
        } else {
            if (!empty($input)) {
                // convert from string to associative array
                $fieldarray = where2array($input);
                // convert back into string after removing non-Pkey fields
                $where      = array2where ($fieldarray, $this->getPkeyNames());
            } else {
                $fieldarray = array();
                $where      = null;
            } // if
        } // if

    	// extract first row for processing
        if (!empty($fieldarray) and !is_string(key($fieldarray))) {
            $firstrow = $fieldarray[key($fieldarray)];
        } else {
            $firstrow = $fieldarray;
        } // if

        // change current table configuraton (optional)
        $firstrow = $this->_cm_changeConfig($where, $firstrow);

        global $mode;
        if ($mode == 'search') {
            // do not allow any $where criteria to be changed
            foreach ($firstrow as $fieldname => $fieldvalue) {
                if (!empty($fieldvalue)) {
                    $this->fieldspec[$fieldname]['noedit'] = 'y';
                    if (eregi('^(null)$', $fieldvalue)) {
                        // replace 'null' (the string) with NULL (the value)
                        $firstrow[$fieldname] = null;
                    } // if
                } // if
            } // foreach

            foreach ($this->fieldspec as $fieldname => $fieldspec) {
                // do not display any fields marked with 'nosearch'
            	if (isset($fieldspec['nosearch'])) {
            	    $this->fieldspec[$fieldname]['nodisplay'] = 'y';
            	} // if
                // do not display autoinsert/autoupdate fields on search screens
                if (array_key_exists('autoinsert', $fieldspec) or array_key_exists('autoupdate', $fieldspec)) {
            	    unset($this->fieldspec[$fieldname]);
            	} // if
            } // foreach

            // look for start_date and end_date in $fieldspec
            if (isset($this->fieldspec['start_date']) and isset($this->fieldspec['end_date'])) {
                $this->setCurrentOrHistoric();
            } // if

            if (isset($_SESSION['search'][$this->tablename])) {
                // retrieve previous search criteria and copy into this screen
                $previous = $_SESSION['search'][$this->tablename];
                // convert from string to associative array
                $previous = where2array($previous);
                // remove any field that does not belong in this table
                foreach ($previous as $field => $value) {
                    if (!array_key_exists($field, $this->fieldspec)) {
                        unset($previous[$field]);
                    } // if
                } // foreach
                $firstrow = array_merge($previous, $firstrow);
                $firstrow = $this->formatData($firstrow);
            } // if
        } // if

        // perform custom processing (such as obtaining lookup lists)
        $firstrow = $this->_cm_getExtraData($where, $firstrow);

        // retrieve data from foreign (parent) tables
        $firstrow = $this->getForeignData($firstrow);

        // put first row back into input array
        if (!empty($fieldarray) and !is_string(key($fieldarray))) {
            $fieldarray[key($fieldarray)] = $firstrow;
        } else {
            $fieldarray = $firstrow;
        } // if

        // store updated $fieldarray within this object
        $this->fieldarray = $fieldarray;

        if ($this->dbname != 'workflow' and $mode == 'update') {
            // find out if this task/context is a workitem within a workflow instance
            $this->_examineWorkflowInstance($where);
        } // if

        return $fieldarray;

    } // getExtraData

    // ****************************************************************************
    function getFieldArray ()
    // return array of data that currently resides within this object
    // (usually stuff which was retrieved from the database).
    {
        if (isset($this->fieldarray)) {
            if (!empty($this->fieldarray) and !is_string(key($this->fieldarray))) {
                // array is indexed by rownum, so return it 'as is'
                return $this->fieldarray;
            } else {
                // return unindexed array as row zero
                $array[0] = $this->fieldarray;
                return $array;
            } // if
        } else {
            return array();
        } // if

    } // getFieldArray

    // ****************************************************************************
    function getFieldSpec ()
    // return array of field specifications.
    {
        //DebugBreak();
        if (!empty($this->field_access)) {
            // include specified access_type in $fieldspec array
            foreach ($this->field_access as $field_id => $access_type) {
                if (array_key_exists($field_id, $this->fieldspec)) {
                    $this->fieldspec[$field_id][$access_type] = 'y';
                } // if
            } // foreach
        } // if

        return $this->fieldspec;

    } // getFieldSpec

    // ****************************************************************************
    function getFieldSpec_original ()
    // set the specifications for this database table.
    {
        //DebugBreak();
		$fieldspec              = array();
        $this->primary_key      = array();
        $this->unique_keys      = array();
        $this->child_relations  = array();
        $this->parent_relations = array();
		$this->audit_logging    = FALSE;
		$this->default_orderby  = '';

        if ($this->getTableName() != 'default') {
            // include table specifications generated by Data Dictionary
            require ($this->dirname .'/' .$this->getTableName() .'.dict.inc');
        } // if

        return $fieldspec;

    } // getFieldSpec_original

    // ****************************************************************************
    function getForeignData ($fieldarray)
    // Retrieve data from foreign (parent) database tables.
    // (parent tables are identified in $this->parent_relations)
    {
        if (empty($fieldarray)) {
            return $fieldarray;
        } // if

		//perform custom processing before standard processing
        $fieldarray = $this->_cm_getForeignData($fieldarray);

        foreach ($this->parent_relations as $reldata) {
            if (isset($reldata['parent_field'])) {
                // process only if parent field does not already exist
                $parent_field = $reldata['parent_field'];
                if (eregi(' AS ', $parent_field, $regs)) {
                    // defined as 'something1 AS something2', so extract something2
                    list($part1, $part2) = explode($regs[0], $parent_field);
                    $parent_field = trim($part2);
                } // if
                if (isset($fieldarray[$parent_field])) {
                    // field is already there, so do nothing
                } else {
    	            // construct WHERE clause to read from parent table
    	            $where = '';
    	            foreach ($reldata['fields'] as $fldchild => $fldparent) {
    	                if (strlen($fldchild) < 1) {
                        	$this->errors[] = getLanguageText('sys0110', strtoupper($tblchild)); // 'Name of child field missing in relationship with $tblchild';
                        	break;
                        } // if
    	                // if any input fields are missing then stop
    	                if (!isset($fieldarray[$fldchild]) or strlen($fieldarray[$fldchild]) == 0) {
                            $where = '';
    	                    break; // skip this $reldata entry
    	                } // if
    	                if (empty($where)) {
    	                    $where = "$fldparent='" .addslashes($fieldarray[$fldchild]) ."'";
    	                } else {
    	                    $where .= " AND $fldparent='" .addslashes($fieldarray[$fldchild]) ."'";
    	                } // if
    	            } // foreach
                    if (empty($where)) {
                        // where is empty, so do nothing
                    } else {
                        $tblparent = $reldata['parent'];
        	            // instantiate an object for this table
        	            if (array_key_exists('subsys_dir', $reldata)) {
        	                $dir = $_SERVER['DOCUMENT_ROOT'] .getParentDIR() .'/' .$reldata['subsys_dir'] .'/';
        	            } else {
        	                $dir = NULL;
        	            } // if
						if (!class_exists($tblparent)) {
						    require_once $dir ."classes/$tblparent.class.inc";
						} // end
        	            $parentobj = new $tblparent;
        	            // retrieve specified field
        	            $parentobj->sql_select = $reldata['parent_field'];
        	            $parent_data = $parentobj->getData($where);
        	            if (count($parent_data) > 0) {
            	            // merge with existing data
            	            $fieldarray = array_merge($fieldarray, $parent_data[0]);
        	            } // if
                    } // if
    			} // if
            } // if
        } // foreach

        return $fieldarray;

    } // getForeignData

    // ****************************************************************************
    function getInitialData ($where)
    // get initial data for new records in this table.
    {
        //DebugBreak();
        $this->errors = array();
        $this->numrows = 0;

        if (!empty($where)) {
            if (is_array($where)) {
                $fieldarray = $where;
            } else {
                // convert 'where' string to an associative array
                $fieldarray = where2array($where);
                // do not allow any items in $where criteria to be changed
                foreach ($fieldarray as $fieldname => $fieldvalue) {
                    if (array_key_exists($fieldname, $this->fieldspec)) {
                        if (!empty($fieldvalue)) {
                            $this->fieldspec[$fieldname]['noedit'] = 'y';
                        } // if
                    } // if
                } // foreach
            } // if
        } else {
            $fieldarray = array();
        } // if

        // do not display autoinsert/autoupdate fields on input screens
        foreach ($this->fieldspec as $field => $spec) {
        	if (array_key_exists('autoinsert', $spec) or array_key_exists('autoupdate', $spec)) {
        	    $this->fieldspec[$field]['nodisplay'] = 'y';
        	} // if
        } // foreach

        // perform any custom processing (optional)
        $fieldarray = $this->_cm_getInitialData($fieldarray);
        if ($this->errors) {
            return $fieldarray;
        } // if

        if (!empty($fieldarray)) {
            // format the data for displaying to the user
            $fieldarray = $this->formatData($fieldarray);
        } // if

        if (version_compare(phpversion(), '4.4.1', '=')) {
            foreach ($fieldarray as $key => $value) {   // fix for version 4.4.1
                $fieldarray[$key] = $value;             // fix for version 4.4.1
            } // foreach                                // fix for version 4.4.1
        } // if
        if (!empty($fieldarray) and !is_string(key($fieldarray))) {
            // this has multiple rows, so ignore
        } else {
            if (is_True($this->ignore_empty_fields)) {
                // do not insert any missing fields
                $this->ignore_empty_fields = false;
            } else {
                // insert any missing fields from $fieldspec
                foreach ($this->fieldspec as $fieldname => $spec) {
                    if (!array_key_exists($fieldname, $fieldarray)) {
                        $fieldarray[$fieldname] = NULL;
                    } // if
                } // foreach
            } // if
        } // if

        $this->fieldarray = $fieldarray;

        if ($this->dbname != 'workflow') {
            if (is_string($where)) {
                // find out if this task/context is a workitem within a workflow instance
                $this->_examineWorkflowInstance($where);
            } // if
        } // if

        return $fieldarray;

    } // getInitialData

    // ****************************************************************************
    function getInstruction ()
    // return an optional instruction to the previous script.
    {
        return $this->instruction;

    } // getInstruction

    // ****************************************************************************
    function getLastIndex ()
    // return the last index number for $this->scrollArray.
    {
        return count($this->scrollarray);

    } // getLastIndex

    // ****************************************************************************
    function getLastPage ()
    // return the last page number for retrieved rows.
    {
        return (int)$this->lastpage;

    } // getLastPage

    // ****************************************************************************
    function getLookupData ()
    // get data to be used in lookups (dropdowns, radio buttons, etc).
    // this is populated in getExtraData().
    {
        if (!empty($this->lookup_data)) {
            return $this->lookup_data;
        } else {
            return array();
        } // if

    } // getLookupData

    // ****************************************************************************
    function getMessages ()
    // return any messages which are not errors.
    {
        if (is_array($this->messages)) {
            $messages = $this->messages;
        } else {
            $messages[] = $this->messages;
        } // if

        $this->messages = array();

        return $messages;

    } // getLookupData

    // ****************************************************************************
    function getNavButtons ($task_id)
    // retrieve any navigation buttons for the current script.
    {
        //DebugBreak();
        $this->errors = array();

        // MNU_NAV_BUTTON contains a list of tran_id's which can be loaded into
        // the current screen's navigation bar.

        // first we must obtain the user's current security setting
        $array = $this->getRole();
        if ($this->errors) return FALSE;
        $role_id       = $array['role_id'];
        $global_access = $array['global_access'];

        require_once 'classes/mnu_nav_button.class.inc';
        $dbobject =& singleton::getInstance('mnu_nav_button');

        if ($global_access) {
            // if global_access is ON then all buttons can be accessed without restriction
            // (unless a transaction has been disabled)
            $dbobject->sql_select = 'x.task_id, x.script_id, mnu_nav_button.button_text, mnu_nav_button.context_preselect';
            $dbobject->sql_from   = 'mnu_nav_button '
                                   .'LEFT JOIN mnu_task ON (mnu_task.task_id = mnu_nav_button.task_id_snr) '
                                   .'LEFT JOIN mnu_task AS x ON (x.task_id = mnu_nav_button.task_id_jnr) ';
            $dbobject->sql_where  = "(x.is_disabled='N') ";
        } else {
            // if global_access is OFF then a button cannot be loaded unless it has an
            // entry on MNU_ROLE_TASK for the current role
            // (or if it has been disabled)
            $dbobject->sql_select = 'x.task_id, x.script_id, mnu_nav_button.button_text, mnu_nav_button.context_preselect';
            $dbobject->sql_from   = 'mnu_nav_button '
                                   .'LEFT JOIN mnu_task ON (mnu_task.task_id = mnu_nav_button.task_id_snr) '
                                   .'LEFT JOIN mnu_task AS x ON (x.task_id = mnu_nav_button.task_id_jnr) '
                                   ."LEFT JOIN mnu_role_task ON (mnu_role_task.task_id=mnu_nav_button.task_id_jnr AND mnu_role_task.role_id='$role_id')";
            $dbobject->sql_where  = "(x.is_disabled='N') "
                                   .'AND (mnu_role_task.role_id IS NOT NULL)';
        } // if

        $dbobject->sql_orderby = 'mnu_nav_button.sort_seq';

        $buttons = $dbobject->getData("mnu_task.task_id='$task_id'");
        $this->errors = $dbobject->getErrors();

        unset($dbobject);

        if (count($buttons) > 0) {
            if (isset($this->sql_search_table)) {
                if (isset($_SESSION['search'][$this->sql_search_table])) {
                    // previous search data is available, so create extra button
                    $buttons = addPreviousSearchButton($buttons);
                } // if
            } else {
                if (isset($_SESSION['search'][$this->tablename])) {
                    // previous search data is available, so create extra button
                    $buttons = addPreviousSearchButton($buttons);
                } // if
            } // if
        } // if

        return $buttons;

    } // getNavButtons

    // ****************************************************************************
    function getNodeData ($expanded, $where=null)
    // retrieve requested tree structure from the database.
    // $expanded may be a list of nodes which are to be expanded, or the word
    // 'ALL' to sigify that all possible nodes should be expanded.
    // $where identifies the start point of a tree structure
    {
        //DebugBreak();
        if (empty($where)) {
            $wherearray = null;
        } else {
            // turn $where string into an associative array
            $wherearray = where2array($where);
        } // if

        if (isset($this->instruction)) {
            // save this until AFTER the call to _cm_getNodeData
            $instruction = $this->instruction;
            unset($this->instruction);
        } // if

        if (empty($expanded)) {
            $expanded = array();
        } // if

        // pass control to custom method
        $fieldarray = $this->_cm_getNodeData($expanded, $where, $wherearray);

        if (isset($instruction)) {
            // process an instructions from a child script
            $this->instruction = $instruction;
            $fieldarray = $this->_processInstruction($fieldarray);
        } // if

        $this->fieldarray = $fieldarray;

        return $fieldarray;

    } // getNodeData

    // ****************************************************************************
    function getNumRows ()
    // return the number of rows retrived for the current page.
    {
        return (int)$this->numrows;

    } // getNumRows

    // ****************************************************************************
    function getOrderBy ()
    // return current sort order.
    {
        if (!empty($this->sql_orderby)) {
            $orderby = $this->sql_orderby;
        } else {
            $orderby = $this->default_orderby;
        } // if

        // strip off any trailing 'asc' or 'desc'
        $pattern = '/( asc| desc)$/';
        if (preg_match($pattern, $orderby, $regs)) {
            $this->sql_orderby_seq = $regs[0];
            $orderby = preg_replace($pattern, '', $orderby, 1);
        } // if

        return $orderby;

    } // getOrderBy

    // ****************************************************************************
    function getOrderBySeq ()
    // return sort sequence ('asc' or 'desc').
    {
        if (empty($this->sql_orderby_seq)) {
            $this->sql_orderby_seq = 'asc'; // default is 'ascending'
        } // if

        return $this->sql_orderby_seq;

    } // getOrderBySeq

    // ****************************************************************************
    function getPageNo ()
    // get current page number to be retrieved for a multi-page display.
    {
        if (empty($this->pageno)) {
            return 0;
        } else {
            return (int)$this->pageno;
        } // if

    } // getPageNo

    // ****************************************************************************
    function getPkeyArray ($fieldarray=null)
    // return the list of primary key values for the last selection of data
    // which was retrieved from this table (or the passed array).
    {
        //DebugBreak();
        if (!empty($fieldarray)) {
            $array = buildPkeyArray($fieldarray, $this->getPkeyNames());
        } else {
            $array = buildPkeyArray($this->fieldarray, $this->getPkeyNames());
        } // if

        foreach ($array as $rownum => $rowdata) {
        	// remove any formatting from each row
            $array[$rownum] = $this->unFormatData($rowdata);
        } // foreach

        return $array;

    } // getPkeyArray

    // ****************************************************************************
    function getPkeyNames ()
    // return the list of primary key fields in this table.
    {
        //DebugBreak();
        if (!empty($this->primary_key)) {
            $array = $this->primary_key;
        } else {
            // get names from contents of $this->fieldspec
            $array = array();
            foreach ($fieldspec as $field => $spec) {
                // look for keyword 'pkey' in field specifications
                if (isset($spec['pkey'])) {
                    $array[] = $field;
                } // if
            } // foreach
        } // if

        return $array;

    } // getPkeyNames

    // ****************************************************************************
    function getRole ()
    // return the role details for the current user.
    {
        //DebugBreak();
        $this->errors = array();

        if (!isset($_SESSION['role_id'])) {
            // not found, so assume user has global access
            $array = array('role_id' => 'GLOBAL', 'global_access' => true);
            $_SESSION['role_id']       = 'GLOBAL';
            $_SESSION['global_access'] = TRUE;
        } elseif (isset($_SESSION['global_access'])) {
            $array['role_id']       = $_SESSION['role_id'];
            $array['global_access'] = $_SESSION['global_access'];
        } else {
            // look for security class from logon screen
            $role_id = $_SESSION['role_id'];
            require_once 'classes/mnu_role.class.inc';
            $dbobject =& singleton::getInstance('mnu_role');
            $dbobject->sql_select = 'role_id,global_access';
            $role_data = $dbobject->getData("role_id='$role_id'");
            $object_errors = $dbobject->getErrors();
            if ($object_errors) {
                $this->errors = $object_errors;
                return FALSE;
            } // if
            if ($dbobject->numrows <> 1) {
                //$this->errors[] = 'Role does not exist';
                $this->errors[] = getLanguageText('sys0013');
                return FALSE;
            } // if
            $array = $role_data[0];
            if (is_true($array['global_access'])) {
                $array['global_access'] = TRUE;
            } else {
                $array['global_access'] = FALSE;
            } // if
            $_SESSION['global_access'] = $array['global_access'];
            unset($dbobect);
        } // if

       return $array;

    } // getRole

    // ****************************************************************************
    function getScrollIndex ()
    // return current index which points to $scrollarray.
    {
        return $this->scrollindex;

    } // getScrollIndex

    // ****************************************************************************
    function getScrollItem (&$index)
    // pick out the primary key of the selected item from scrollarray and return
    // it in $where so that the script can use it in the next getData() method.
    // NOTE: $index is passed BY REFERENCE as it may be updated.
    {
        //DebugBreak();
        if ($index > count($this->scrollarray)) {
            // index is too high, so reduce it
            $index = count($this->scrollarray);
        } // if

        if (count($this->scrollarray) > 1) {
            // find out if this entry is between a pair of jump points
            $index = findJump($index, $this->scrollindex);
        } // if

        // replace $where with details from the selected entry in scrollarray
        if (is_array($this->scrollarray[$index])) {
            // ensure $where contains nothing but primary key fields
            $where = array2where($this->scrollarray[$index], $this->getPkeyNames());
        } else {
            $where = $this->scrollarray[$index];
        } // if

        // set values to be used by scrolling logic
        $this->scrollindex = $index;
        $this->pageno      = $index;
        $this->lastpage    = count($this->scrollarray);

        return $where;

    } // getScrollItem

    // ****************************************************************************
    function getScrollSize ()
    // return size of current $scrollarray.
    {
        return count($this->scrollarray);

    } // getScrollSize

    // ****************************************************************************
    function getTableName ()
    // return the name of this table.
    {
        return strtolower($this->tablename);

    } // getTableName

    // ****************************************************************************
    function getValRep ($item, $where=null)
    // get Value/Representation list from this table.
    {
        // call custom method to obtain data as an associative array.
        $array = $this->_cm_getValRep(strtolower($item), $where);

        return $array;

    } // getValRep

    // ****************************************************************************
    function getWhere ()
    // return current selection criteria (may have been amended).
    {
        return $this->where;

    } // getWhere

    // ****************************************************************************
    function initialise ($where=null, $selection=null)
    // perform any initialisation for the current task.
    {
        // change current table configuraton (optional)
        $null = $this->_cm_changeConfig($where, array());

        // call customisable method in the subclass.
        $where = $this->_cm_initialise($where, $selection);

        return $where;

    } // getWhere

    // ****************************************************************************
    function insertMultiple ($fieldarray)
    // insert multiple records using data in $fieldarray.
    {
        $errors = array();
        $count  = 0;

        if (is_string(key($fieldarray))) {
            // array is NOT indexed by row, so adjust it
            $array[] = $fieldarray;
            $fieldarray = $array;
        } // if

        // perform any additional custom pre-processing
        $fieldarray = $this->_cm_pre_insertMultiple($fieldarray);

        // insert each row one by one
        foreach ($fieldarray as $row => $data) {
            if (!empty($data)) {
                $fieldarray[$row] = $this->insertRecord($fieldarray[$row]);
                if (!empty($this->errors)) {
                    // keep $errors separate for each row
                    $errors[$row] = $this->errors;
                } else {
                    $count++;
                } // if
            } // if
        } // foreach

        $this->errors  = $errors;
        $this->numrows = $count;
        //$this->messages[] = $count .' records were inserted into ' .strtoupper($this->tablename);
        $this->messages[] = getLanguageText('sys0005', $count, strtoupper($this->tablename));

        // perform any additional custom post-processing
        $fieldarray = $this->_cm_post_insertMultiple($fieldarray);

        return $fieldarray;

    } // insertMultiple

    // ****************************************************************************
    function insertRecord ($fieldarray)
    // insert a record using contents of $fieldarray.
    {
        //DebugBreak();
        $this->errors = array();   // initialise

        if (!empty($fieldarray)) {
        	if (!is_string(key($fieldarray))) {
                // input is indexed by row, so extract data for 1st row only
                $array = $fieldarray[key($fieldarray)];
                $fieldarray = $array;
            } // if
        } // if

        // do not allow auto-insert/autoupdate fields to be pasted into an insert screen
        foreach ($this->fieldspec as $field => $spec) {
        	if (array_key_exists('autoinsert', $spec) or array_key_exists('autoupdate', $spec)) {
        	    unset($fieldarray[$field]);
        	} // if
        } // foreach

        $entry = getEntryPoint($this);
        if (strtolower($entry) != 'insertmultiple') {
            // redo any custom initialisation
            $fieldarray = $this->_cm_getInitialData($fieldarray);
        } // if

        // perform any custom pre-insert processing
        $fieldarray = $this->_cm_pre_insertRecord($fieldarray);

        if (empty($this->errors)) {
            // perform standard declarative checks on input array
            // NOTE: this produces another array with data formatted for the database
            $insertarray = $this->validateInsert($fieldarray);
        } else {
            $insertarray = $fieldarray;
        } // if

        if (empty($this->errors)) {
            if ($this->skip_validation) {
                // do not perform any custom validation
            } else {
                // perform any custom pre-insert validation (1)
                $insertarray = $this->_cm_commonValidation($insertarray, $fieldarray);
                if (empty($this->errors)) {
                    // perform any custom pre-insert validation (2)
                    $insertarray = $this->_cm_validateInsert($insertarray);
                } // if
            } // if
        } // if

        // remove any autoinsert or autoupdate fields
        foreach ($this->fieldspec as $field => $spec) {
            if (array_key_exists('autoinsert', $spec)) {
                // not allowed to specify during insert
                unset($insertarray[$field]);
            } // if
            if (array_key_exists('autoupdate', $spec)) {
                // not allowed to specify during insert
                unset($insertarray[$field]);
            } // if
        } // foreach

        if (empty($this->errors)) {
            // perform standard insert using validated data
            $insertarray = $this->_dml_insertRecord($insertarray);
        } // if

        // replace any fields excluded from $insertarray
        $fieldarray = array_merge($fieldarray, $insertarray);

        if (empty($this->errors)) {
            if ($this->skip_validation) {
                // do not perform any custom processing
            } else {
                // perform any custom post-insert processing
                $fieldarray = $this->_cm_post_insertRecord($fieldarray);
            } // if
        } // if

        // turn this flag off
        $this->skip_validation = FALSE;

        // format data for output to the user
        $fieldarray = $this->formatData($fieldarray);

        // store updated $fieldarray within this object
        $this->fieldarray = $fieldarray;

        if (empty($this->errors)) {
            $this->numrows = $this->numrows +1;
        } // if

        return $fieldarray;

    } // insertRecord

    // ****************************************************************************
    function popupCall ($popupname, $where, &$script_vars, $fieldarray, &$settings)
    // processing before a popup form is called.
    // NOTE: $script_vars is passed BY REFERENCE as it may be altered.
    {
        // allow $where to be altered if necessary
        $where = $this->_cm_popupCall(strtolower($popupname), $where, $fieldarray, $settings);

        // clear any previous selection
        $script_vars['selection'] = NULL;

        return $where;

    } // popupCall

    // ****************************************************************************
    function popupReturn ($fieldarray, $return_from, $selection)
    // process a selection returned from a popup screen.
    // $fieldarray contains the record data when the popup button was pressed.
    // $return_from identifies which popup screen was called.
    // $selection contains an array of item(s) selected in that popup screen.
    {
        //DebugBreak();
        $this->errors = array();

        $return_from = strtolower($return_from);

        if (!empty($fieldarray) and !is_string(key($fieldarray))) {
            // indexed by row, so use 1st row only
            $fieldarray = $fieldarray[key($fieldarray)];
        } // if

        if (substr_count($selection, '=') == 0) {
            // selection is not in format 'key=value', so it must be from a filepicker
            foreach ($this->fieldspec as $field => $spec) {
                if (isset($spec['task_id'])) {
                    if ($spec['task_id'] == $return_from) {
                        // now empty the description field obtained from the foreign table
                        $fieldarray[$field] = $selection;
                        break;
                    } // if
                } // if
            } // foreach
            // store updated $fieldarray within this object
            $this->fieldarray = $fieldarray;
            return $fieldarray;
        } // if

        // convert selection string into an associative array
        $select_array = where2array($selection);

        // merge $selection with $fieldarray
        $fieldarray = array_merge($fieldarray, $select_array);

        // find entry which uses this popup form
        foreach ($this->fieldspec as $field => $spec) {
            if (isset($spec['task_id'])) {
                if ($spec['task_id'] == $return_from) {
                    // now empty the description field obtained from the foreign table
                    if (isset($spec['foreign_field'])) {
                        $fieldarray[$spec['foreign_field']] = null;
                    } // if
                    break;
                } // if
            } // if
        } // foreach

        // call custom method for specific processing
        $fieldarray = $this->_cm_popupReturn($fieldarray, $return_from, $selection);

        if ($GLOBALS['mode'] == 'insert') {
            // redo any custom initialisation
            $fieldarray = $this->_cm_getInitialData($fieldarray);
        } // if

        // retrieve data from foreign (parent) tables
        $fieldarray = $this->getForeignData($fieldarray);

        // store updated $fieldarray within this object
        $this->fieldarray = $fieldarray;

        return $fieldarray;

    } // popupReturn

    // ****************************************************************************
    function reInitialise ($fieldarray, $where)
    // re-initialise $fieldarray after previous insert
    {
        // nullify all fields identified in $fieldspec
        foreach ($this->fieldspec as $fieldname => $spec) {
            $fieldarray[$fieldname] = NULL;
        } // foreach

        $this->fieldarray = $fieldarray;

        return $fieldarray;

    } // reInitialise

    // ****************************************************************************
    function rollback ()
    // rollback this transaction due to some sort of error.
    {
        $DML =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $result = $DML->rollback($this->dbname);

        $GLOBALS['transaction_has_started'] = FALSE;

        return $result;

    } // rollback

    // ****************************************************************************
    function selectDB ($dbname)
    // select a different database via the current connection.
    {
        $DML =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $result = $DML->selectDB($dbname);

        return $result;

    } // selectDB

    // ****************************************************************************
    function setAction ($action)
    // process the designated action within the current object.
    {
        //DebugBreak();
        $this->errors = array();

        switch (strtolower($action)){
            case 'selectall':
                $this->selectall = true;
                foreach ($this->fieldarray as $row => $data) {
                    $this->fieldarray[$row]['selected'] = true;
                } // foreach
                break;
            case 'unselectall':
                $this->selectall = false;
                foreach ($this->fieldarray as $row => $data) {
                    $this->fieldarray[$row]['selected'] = false;
                } // foreach
                break;
            default:
                $this->errors[] = getLanguageText('sys0012'); // 'setAction: 2nd parameter is unknown action'
        } // switch

        return $this->fieldarray;

    } // setAction

    // ****************************************************************************
    function setCurrentOrHistoric ()
    // this table contains fields START_DATE and END_DATE, so insert into search
    // screen a dropdown list to select 'current', 'historic' or 'all' dates.
    {

        // create array of options and and put into LOOKUP_DATA
        $array['C'] = 'Current';
        $array['H'] = 'Historic';
        $array['A'] = 'All';
        $this->lookup_data['curr_or_hist'] = $array;

        // insert field into $fieldspec
        $this->fieldspec['curr_or_hist'] = array('type' => 'string',
                                                 'control' => 'dropdown',
                                                 'optionlist' => 'curr_or_hist');
        return;

    } // setCurrentOrHistoric

    // ****************************************************************************
    function setDefaultOrderBy ($sql_orderby='')
    // this allows a default sort order to be specified (see getData)
    {
        // only set if non-null value is given
        if (!empty($sql_orderby)) {
            $this->default_orderby = trim($sql_orderby);
        } // if

    } // setDefaultOrderBy

    // ****************************************************************************
    function setFieldAccess ()
    // get contents of ROLE_TASKFIELD for this role/task.
    // this identifies if access to certain fields should be turned off.
    {
        //DebugBreak();
        $this->errors = array();
        $array = array();

        // MNU_ROLE_TASKFIELD contains a list of fields for the current task
        // which may have the default ACCESS_TYPE altered for the current role.

        // first we must obtain the user's current role setting
        $role_data = $this->getRole();
        if ($this->errors) return FALSE;

        $role_id       = $role_data['role_id'];
        $global_access = $role_data['global_access'];

        // If the security class has GLOBAL_ACCESS = 'y' there are no restrictions.
        if ($global_access) return $array;

        //DebugBreak();
        require_once 'classes/mnu_role_taskfield.class.inc';
        $dbobject =& singleton::getInstance('mnu_role_taskfield');

        $dbobject->sql_select = 'role_id,task_id,field_id,access_type';
        $dbobject->sql_from   = 'mnu_role_taskfield ';
        $dbobject->sql_where  = "mnu_role_taskfield.role_id='$role_id' ";

        $dbobject->sql_orderby = '';
        $PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'
        $where = "task_id='" .$_SESSION[$PHP_SELF]['task_id'] ."'";

        $accessarray = $dbobject->getData($where);
        $this->errors = $dbobject->getErrors();

        unset($dbobject);

        // $accessarray contains a separate row for each field which must now be
        // reduced to an associative array of 'field_id=access_type'
        $array = array();
        foreach ($accessarray as $row => $rowdata) {
            $fieldname  = strtolower($rowdata['field_id']);
            $fieldvalue = strtolower($rowdata['access_type']);
            // set access type for the field
            switch ($fieldvalue) {
            	case 'ned':
            		$array[$fieldname] = 'noedit';
            		break;
            	case 'ndi':
            		$array[$fieldname] = 'nodisplay';
            		break;
            	default:
            		// ignore if access_type='full' (no restrictions)
            } // switch
        } // foreach

        $this->field_access = $array;

        return $array;

    } // setFieldAccess

    // ****************************************************************************
    function setFieldArray ($fieldarray)
    // this allows the current data array to be set or updated.
    {
        if (empty($fieldarray)) {
            $this->fieldarray = array();
        } else {
            if (!is_string(key($fieldarray))) {
                // input is indexed by row, so use it 'as is'
                $this->fieldarray = $fieldarray;
            } else {
                // input is not indexed by row, so make it row zero
                $this->fieldarray = array();
                $this->fieldarray[0] = $fieldarray;
            } // if
        } // if

        $this->numrows = count($this->fieldarray);

        return;

    } // setFieldArray

    // ****************************************************************************
    function setInstruction ($instruction)
    // load an optional instruction from the previous script.
    {
        $this->instruction = $instruction;

    } // setInstruction

    // ****************************************************************************
    function setLookupData ($input=null)
    // fetch any lookup data and load into member variable.
    {
        //DebugBreak();
        // $input may be an array or a string
        if (is_array($input)) {
            if (!empty($input) and !is_string(key($input))) {
                // indexed by row, so use only row zero
                $fieldarray = $input[key($input)];
            } else {
                $fieldarray = $input;
            } // if
            // convert into string after removing non-Pkey fields
            $where = array2where ($fieldarray, $this->getPkeyNames());
        } else {
            if (!empty($input)) {
                // convert from string to an associative array
                $fieldarray = where2array($input);
                // convert back into string after removing non-Pkey fields
                $where      = array2where ($fieldarray, $this->getPkeyNames());
            } else {
                $fieldarray = array();
                $where      = null;
            } // if
        } // if

        // change current table configuraton (optional)
        $fieldarray = $this->_cm_changeConfig($where, $fieldarray);

        // perform custom processing (such as obtaining lookup lists)
        $fieldarray = $this->_cm_getExtraData($where, $fieldarray);

        return $fieldarray;

    } // setLookupData

    // ****************************************************************************
    function setOrderBy ($sql_orderby, $sql_orderby_seq=null)
    // this allows a sort order to be specified (see getData)
    {
        //DebugBreak();
        $sql_orderby = trim(strtolower($sql_orderby));

        $array1 = explode(",", $sql_orderby);
        $array2 = array();
        foreach ($array1 as $field) {
        	if (array_key_exists($field, $this->fieldspec)) {
            	$array2[] = qualifyOrderby($field, $this->tablename, $this->getFieldSpec_original());
            } elseif (!empty($this->sql_sort_table)) {
                $array2[] = $this->sql_sort_table .'.' .$field;
            } else {
                // does not belong, so filter it out
            } // if
        } // foreach

        $this->sql_orderby = implode(",", $array2);

        if (empty($this->sql_orderby)) {
            $this->sql_orderby_seq = NULL;
        } else {
            if (!empty($sql_orderby_seq)) {
            	$this->sql_orderby_seq == $sql_orderby_seq;
            } else {
                // toggle 'orderby_seq' between 'asc' and 'desc'
                if ($this->sql_orderby_seq == 'asc') {
                    $this->sql_orderby_seq = 'desc';
                } else {
                    $this->sql_orderby_seq = 'asc';
                } // if
            } // if
        } // if

    } // setOrderBy

    // ****************************************************************************
    function setOrderBySeq ($sql_orderby_seq)
    // this allows a sort sequence ('asc' or 'desc') to be set (see getData)
    {
        $this->sql_orderby_seq = trim($sql_orderby_seq);

    } // setOrderBySeq

    // ****************************************************************************
    function setPageNo ($pageno='1')
    // this allows a particular page number to be selected (see getData)
    {
        $this->pageno = abs((int)$pageno);

    } // setPageNo

    // ****************************************************************************
    function setRowsPerPage ($rows_per_page)
    // this allows the default value to be changed
    {
        $this->rows_per_page = abs((int)$rows_per_page);

    } // setRowsPerPage

    // ****************************************************************************
    function setScrollArray ($where)
    // construct an array of prmary keys using the contents of $where
    {
        //DebugBreak();
        // convert $where (string) into an array of 'name=value' pairs
        $wherearray = where2array($where);

        // call custom method to construct $this->scrollarray
        $array = $this->_cm_setScrollArray($where, $wherearray);

        // shift entries so that they start at position 1 not 0
        array_unshift($array, 'dummy');
        unset($array[0]);

        // save this array for use during this object's life
        $this->scrollarray = $array;

        // replace $where with details from 1st entry in scrollarray
        if (is_array($this->scrollarray[1])) {
            $where = array2where($this->scrollarray[1]);
        } else {
            $where = $this->scrollarray[1];
        } // if

        // set initial values to be used by scrolling logic
        $this->scrollindex = 1;
        $this->pageno      = 1;
        $this->numrows  = count($this->scrollarray);
        $this->lastpage = count($this->scrollarray);

        return $where;

    } // setScrollArray

    // ****************************************************************************
    function setScrollIndex ($index='1')
    // this allows a particular index number to be selected (see getData)
    {
        $this->scrollindex = abs((int)$index);

    } // setScrollIndex

    // ****************************************************************************
    function setSqlSearch ($sql_search)
    // set additional criteria to be used in sql select
    {
        $this->sql_search = $sql_search;

        // this causes following variables to be reset
        $this->pageno          = 1;
        $this->sql_orderby     = NULL;
        $this->sql_orderby_seq = NULL;

    } // setSqlSearch

    // ****************************************************************************
    function setSelectArray ($selection)
    // set optional selection criteria to be used in sql select
    {
        if (is_array($selection)) {
            // use only 1st element of this array
            $this->selectarray = $selection[key($selection)];
        } else {
            // convert string to an associative array
            $this->selectarray = where2array($selection);
        } // if

    } // setSelectArray

    // ****************************************************************************
    function sqlAssembleWhere ($where, $where_array)
    // assemble the $where clause from its component parts.
    // ($where = string, $where_array = array)
    {
        //DebugBreak();
        if (is_True($this->is_link_table)) {
            // this is for an outer-link-inner relationship
            $where = $this->sqlAssembleWhereLink($where, $where_array);
        } // if

        if ($this->checkPrimaryKey or empty($this->sql_from) or $this->sql_from == $this->tablename) {
            // check that 'where' clause does not contain any fields that
            // are not in this table, otherwise it will cause an error
            $where = WhereFilter($where, $this->fieldspec, $this->tablename);
        } // if

        if (empty($this->sql_from)) {
        	// obtain fields from foreign tables via a JOIN, if necessary
        	$this->sql_from = $this->sqlForeignJoin($this->sql_select, $this->sql_from, $this->parent_relations);
        } // if

        if (!empty($this->sql_search)) {
            // turn 'current/historic/future' into a range of dates
            $this->sql_search = currentOrHistoric($this->sql_search);
        } // if

        if (empty($this->sql_from) or $this->sql_from == $this->tablename) {
            // check that 'search' clause does not contain any fields that
            // are not in this table, otherwise it will cause an error
            $this->sql_search  = whereFilter($this->sql_search, $this->fieldspec, $this->tablename);
            //$this->sql_orderby = orderbyFilter($this->sql_orderby, $this->fieldspec, $this->tablename);
        } // if

        if (!empty($this->sql_search)) {
            if (!empty($this->xref_item)) {
                // replace 'selected' with correct column name, testing for T/Y and F/N
                $replace = array("selected LIKE 'Y'", "selected LIKE 'T'");
                $replace_with = "$this->xref_item IS NOT NULL";
                $this->sql_search = str_replace($replace, $replace_with, $this->sql_search);
                $replace = array("selected LIKE 'N'", "selected LIKE 'F'");
                $replace_with = "$this->xref_item IS NULL";
                $this->sql_search = str_replace($replace, $replace_with, $this->sql_search);
            } else {
                // ensure that 'selected' column is not specified in search criteria
                $replace = array("selected LIKE 'Y'", "selected LIKE 'T'", "selected LIKE 'N'", "selected LIKE 'F'");
                $replace_with = null;
                $this->sql_search = str_replace($replace, $replace_with, $this->sql_search);
            } // if

            if (!empty($this->sql_search) AND !empty($this->sql_search_table)) {
                // qualify each column name to avoid conflict with other tables
                $this->sql_search = qualifyWhere($this->sql_search, $this->sql_search_table);
            } // if

            if (!empty($this->sql_search)) {
                // merge $where with optional search criteria
                if (empty($where)) {
                    $where = $this->sql_search;
                } else {
                    $where = mergeWhere($this->sql_search, $where);
                } // if
                $where_array = where2indexedArray($where);
            } // if
        } // if

        if (!empty($this->sql_from)) {
            // qualify column names with the table name in case
            // there is a conflicting column name on the joined table
            $where = qualifyWhere($where, $this->tablename, $this->fieldspec);
            $this->default_orderby = qualifyOrderby($this->default_orderby, $this->tablename, $this->fieldspec);
        } // if

        // the 'where' sring may come in two parts
        if (empty($this->sql_where)) {
            $where_str = $where;
        } else {
            // incorporate optional 'sql_where' criteria
            if (!empty($where)) {
                $where_str = "$where AND $this->sql_where";
            } else {
                $where_str = "$this->sql_where";
            } // if
        } // if

        return $where_str;

    } // sqlAssembleWhere

    // ****************************************************************************
    function sqlAssembleWhereLink ($where, $where_array)
    // in a many-link-many relationship this will assemble the SQL commands for
    // the middle (link) table.
    {
        //DebugBreak();
        if (isset($this->xref_item)) {
            // this has already been processed, so don't do it again
            return $where;
        } // if

        if (!is_string(key($where_array))) {
        	$where_array = indexed2assoc($where_array);
        } // if

        // step through $parent_relations until the OUTER entity is found
        foreach ($this->parent_relations as $reldata) {
        	if ($reldata['parent'] == $this->outer_table) {
        	    $outer_table     = $reldata['parent'];
                $outer_alias     = '';
                break;
            } else if (isset($reldata['alias']) and $reldata['alias'] == $this->outer_table) {
                $outer_table     = $reldata['parent'];
                $outer_alias     = $reldata['alias'];
                break;
        	} // if
        } // foreach

        // identify felds which join the OUTER table to the LINK table
        foreach ($reldata['fields'] as $fldchild => $fldparent) {
        	$outer_key[]        = $outer_table .'.' .$fldparent;
            $ix = count($outer_key) -1;
            if ($fldchild == $fldparent) {
                $outer_key_as[] = $outer_key[$ix];
            } else {
                $outer_key_as[] = $outer_key[$ix] .' AS ' .$fldchild;
            } // if
            $outer_link[]       = $outer_key[$ix] .'=' .$this->tablename .'.' .$fldchild;
        } // foreach

        if (!isset($this->inner_table)) {
            // if OUTER table is defined, then INNER must be as well
            trigger_error(getLanguageText('sys0011'), E_USER_ERROR); // 'Definition of INNER_TABLE is missing'
        } // if

        if (empty($this->sql_search_table)) {
        	$this->sql_search_table = $this->inner_table;
        } // if
        $this->sql_sort_table   = $this->inner_table;

        // step through $parent_relations until the INNER entity is found
        foreach ($this->parent_relations as $reldata) {
        	if ($reldata['parent'] == $this->inner_table) {
                $inner_table     = $reldata['parent'];
                $inner_alias     = '';
                break;
            } elseif (isset($reldata['alias']) and $reldata['alias'] == $this->inner_table) {
                $inner_table     = $reldata['parent'];
                $inner_alias     = $reldata['alias'];
                break;
            } // if
        } // foreach

        // identify felds which join the INNER table to the LINK table
        foreach ($reldata['fields'] as $fldchild => $fldparent) {
            if (empty($inner_alias)) {
                $inner_key[]    = $inner_table .'.' .$fldparent;
            } else {
                $inner_key[]    = $inner_alias .'.' .$fldparent;
            } // if
            $ix = count($inner_key) -1;
            if ($fldchild == $fldparent) {
                $inner_key_as[] = $inner_key[$ix];
            } else {
                $inner_key_as[] = $inner_key[$ix] .' AS ' .$fldchild;
            } // if
            $inner_link[]       = $inner_key[$ix] .'=' .$this->tablename .'.' .$fldchild;
        } // foreach

        $this->xref_item = $this->tablename .'.' .$fldchild;

        // assemble the sql SELECT clause
        $sql_select = '';
        foreach ($outer_key_as as $field) {
            $sql_select .= $field .', ';
        } // foreach
        foreach ($inner_key_as as $field) {
            $sql_select .= $field .', ';
        } // foreach

        if (strlen($this->sql_select) > 0) {
            // use supplied value
            $sql_select .= $this->sql_select;
        } else {
            // use default value
            $sql_select .= $reldata['parent_field'];
        } // if

        $this->sql_select = $sql_select .", CASE WHEN $this->xref_item IS NULL THEN 'F' ELSE 'T' END AS selected";

        // assemble the sql FROM clause
        $sql_from   = $outer_table .' CROSS JOIN ';

        if (empty($inner_alias)) {
            $sql_from .= $inner_table;
        } else {
            $sql_from .= $inner_table .' AS ' .$inner_alias;
        } // if

        $sql_from  .= ' LEFT JOIN ' .$this->tablename .' ON (';
        foreach ($outer_link as $link) {
            $sql_from .= $link .' AND ';
        } // foreach
        foreach ($inner_link as $link) {
            $sql_from .= $link .' AND ';
        } // foreach
        $sql_from = rtrim($sql_from, ' AND');
        $sql_from .= ')';

        $this->sql_from = $sql_from .' ' .$this->sql_from;

        return $where;

    } // sqlAssembleWhereLink

    // ****************************************************************************
    function sqlForeignJoin (&$select, $from, $parent_relations)
    // if there are parent relations then construct a JOIN
    // Note that $select is passed by reference as it may be amended
    {
        if (empty($parent_relations)) {
        	return $from;
        } // if

        if (empty($select)) {
        	$select = $this->tablename .'.*';
        } else {
            $select = qualifySelect($select, $this->tablename, $this->fieldspec);
        } // if

        if (empty($from)) {
        	$from = $this->tablename;
        } // if

        foreach ($this->parent_relations as $reldata) {
            if (!isset($reldata['parent_field'])) {
            	// parent_field is not defined, so ignore this entry
            } else {
                $parent_fueld = $reldata['parent_field'];
                // does this belong to another database/schema?
                if (isset($reldata['dbname'])) {
                	$dbname = $reldata['dbname'] .'.';
                } else {
                    $dbname = '';
                } // if
                if (isset($reldata['alias'])) {
                	$alias = $reldata['alias'];
                } else {
                    $alias = '';
                } // if
                // put field from foreign table into SELECT area
                if (substr_count($reldata['parent_field'],' ') == 0) {
                    // parent_field is a single word (no spaces)
                	$select .= ', ' .$reldata['parent'] .'.' .$reldata['parent_field'];
                } else {
                    $select .= ', ' .$reldata['parent_field'];
                } // if
                // build JOIN using supplied field names
                if (!empty($alias)) {
                	$from .= ' LEFT JOIN ' .$dbname .$reldata['parent']  .' AS ' .$alias .' ON (';
                } else {
                    $from .= ' LEFT JOIN ' .$dbname .$reldata['parent']  .' ON (';
                } // if
                foreach ($reldata['fields'] as $fldchild => $fldparent) {
                    if (!empty($alias)) {
                        $from .= $alias .'.' .$fldparent .'=' .$this->tablename .'.' .$fldchild .' AND ';
                    } else {
                        $from .= $reldata['parent'] .'.' .$fldparent .'=' .$this->tablename .'.' .$fldchild .' AND ';
                    } // if
                } // foreach
                // replace trailing 'AND' with ')'
                $from = rtrim($from, ' AND') .') ';
            } // if
        } // foreach

        return $from;

    } // sqlForeignJoin

    // ****************************************************************************
    function startTransaction ()
    // start a new transaction, to be terminated by either COMMIT or ROLLBACK.
    {
        //DebugBreak();
        $DML =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $GLOBALS['lock_tables'] = FALSE;    // set default, may be changed
        $GLOBALS['lock_rows']   = FALSE;    // set default, may be changed

        // get optional locks from current object
        $lock_array = $this->_cm_getDatabaseLock();

        $new_array = array();

        if ($GLOBALS['lock_tables'] == TRUE) {
            if (empty($lock_array)) {
                $lock_array['WRITE'][] = $this->tablename;
            } // if

            foreach ($lock_array as $row => $data) {
                // if no READ/WRITE lock is specified, default to WRITE
            	if (!preg_match('/^(READ|WRITE)$/i', $row, $regs)) {
                    $lock_array['WRITE'][] = $data;  // insert new entry
            	    unset($lock_array[$row]);        // delete old entry
                } // if
            } // foreach

            // set up array of standard locks
            $std_lock['WRITE']['audit'][]    = 'audit_ssn';
            $std_lock['WRITE']['audit'][]    = 'audit_trn';
            $std_lock['WRITE']['audit'][]    = 'audit_tbl';
            $std_lock['WRITE']['audit'][]    = 'audit_fld';
            $std_lock['READ'] ['menu'][]     = 'mnu_role';
            $std_lock['READ'] ['menu'][]     = 'mnu_task';
            $std_lock['READ'] ['workflow'][] = 'wf_workflow';
            $std_lock['READ'] ['workflow'][] = 'wf_place';
            $std_lock['READ'] ['workflow'][] = 'wf_transition';
            $std_lock['READ'] ['workflow'][] = 'wf_arc';
            $std_lock['WRITE']['workflow'][] = 'wf_case';
            $std_lock['WRITE']['workflow'][] = 'wf_token';
            $std_lock['WRITE']['workflow'][] = 'wf_workitem';

            // compare $lock_array with $std_locks looking for duplicates
            // NOTE: a WRITE lock will replace a READ lock
            foreach ($lock_array as $mode => $mode_array) {
            	foreach ($mode_array as $row => $tablename) {
                	if (strpos($tablename, '.')) {
                        // split into $tablename and $fieldname
                        list($dbname, $tablename) = explode('.', $tablename);
                    } else {
                        $dbname = $this->dbname;
                    } // if
                    if (array_key_exists($dbname, $std_lock['READ'])) {
                    	if (in_array($tablename, $std_lock['READ'][$dbname])) {
                    	    if ($mode == 'WRITE') {
                    	        $stdrow = array_search($tablename, $std_lock['READ'][$dbname]);
                    	    	unset($std_lock['READ'][$stdrow]);
                    	    } else {
                        	    unset($lock_array[$mode][$row]);
                    	    } // if
                        } // if
                    } // if
                    if (array_key_exists($dbname, $std_lock['WRITE'])) {
                        if (in_array($tablename, $std_lock['WRITE'][$dbname])) {
                        	unset($lock_array[$mode][$row]);
                        } // if
                    } // if
                } // foreach
            } // foreach

            global $dbprefix; // to be used in front of database names

            // transfer $lock_array to $new_array
            foreach ($lock_array as $mode => $mode_array) {
                foreach ($mode_array as $row => $tablename) {
                	if (strpos($tablename, '.')) {
                        $new_array[$mode][] = $dbprefix .$tablename;
                    } else {
                        $new_array[$mode][] = $tablename;
                    } // if
                } // foreach
            } // foreach

            // transfer $std_lock to $new_array
            foreach ($std_lock as $mode => $mode_array) {
                foreach ($mode_array as $std_dbname => $std_table_array) {
                    foreach ($std_table_array as $std_tablename) {
                        if ($std_dbname == $this->dbname) {
                        	$new_array[$mode][] = $std_tablename;
                        } else {
                            $new_array[$mode][] = $dbprefix .$std_dbname .'.' .$std_tablename;
                        } // if
                    } // foreach
                } // foreach
            } // foreach

        } // if

        $DML->table_locks = $new_array;

        $result = $DML->startTransaction($this->dbname);

        $GLOBALS['transaction_has_started'] = TRUE;

        return $result;

    } // startTransaction

    // ****************************************************************************
    function unFormatData ($fieldarray)
    // remove any formatting before data is given to the database.
    // (such as changing dates from 'dd Mmm CCYY' to 'CCYY-MM-DD')
    {
        //DebugBreak();
        static $dateobj;

        if (!isset($dateobj)) {
            require_once 'std.datevalidation.class.inc';
            $dateobj =& singleton::getInstance('date_class');
        } // if

        foreach ($fieldarray as $fieldname => $fieldvalue) {
            // only deal with fields defined in $fieldspec
            if (isset($this->fieldspec[$fieldname])) {
                // get specifications for current field
                $fieldspec = $this->fieldspec[$fieldname];
                if (!isset($fieldspec['type'])) {
                    $fieldspec['type'] = 'string';  // set default type
                } // if

                switch (strtolower($fieldspec['type'])) {
                	case 'string':
                        break;
                	case 'boolean':
                		break;
                	case 'date':
                		if (isset($fieldspec['infinityisnull']) and $fieldvalue == '') {
                            // empty date is shown in the database as infinity
                            $fieldarray[$fieldname] = '9999-12-31';
                        } else {
                            // convert date from external to internal format
                            $fieldarray[$fieldname] = $dateobj->getInternalDate($fieldvalue);
                        } // if
                		break;
                	case 'datetime':
                		// convert date from external to internal format
                        $fieldarray[$fieldname] = $dateobj->getInternalDateTime($fieldvalue);
                        break;
                	case 'time':
                		break;
                	case 'float':
                    case 'double':
                    case 'real':
                		break;
                	default:
                		;
                } // switch

            } // if
        } // foreach

        // perform any custom unformatting
        $fieldarray = $this->_cm_unFormatData($fieldarray);

        return $fieldarray;

    } // unFormatData

    // ****************************************************************************
    function updateLinkData ($fieldarray, $postarray)
    // $fieldarray is an array of field data (usually just primary keys).
    // $postarray is an array of entries which have been selected.
    // For each entry where SELECTED=TRUE make sure a database entry exists.
    // For each entry where SELECTED=FALSE make sure a database entry does not exist.
    {
        //DebugBreak();
        $this->errors = array();

        // perform any custom pre-update processing
        $fieldarray = $this->_cm_pre_updateLinkData($fieldarray, $postarray);
        if (!empty($this->errors)) return $fieldarray;

        // transfer values from $postarray to $fieldarray
        // each fieldname in $postarray contains an array of values
        foreach ($postarray as $fieldname => $valuearray) {
            if ($fieldname <> 'select') {
                if (is_array($valuearray)) {
                    // copy row value from $postarray to $fieldarray for current $fieldname
                    foreach ($valuearray as $row => $value) {
                        // $fieldarray starts at 0, $postarray starts at 1
                        $fieldarray[$row-1][$fieldname] = $postarray[$fieldname][$row];
                    } // foreach
                } // if
            } // if
        } // foreach

        if (!empty($this->errors)) {
            return $fieldarray;
        } // if

        $errors = array();

        // get array of fieldnames in the primary key
        $pkeynames = $this->getPkeyNames();

        foreach ($fieldarray as $rownum => $rowdata) {

            // construct 'where' clause from primary key
            $where = array2where($rowdata, $pkeynames);

            // find out if this record currently exists or not
            $count = $this->getCount($where);

            // perform action depending on value in $select array
            if (isset($postarray['select'][$rownum+1])) {
                $fieldarray[$rownum]['selected'] = 'T';
                // row is marked for insert/update
                if ($count == 0) {
                    // record does not exist, so create it
                    $rowdata = $this->insertRecord($rowdata);
                } else {
                    // record already exists, so update it
                    $rowdata = $this->updateRecord($rowdata);
                } // if
            } else {
                $fieldarray[$rownum]['selected'] = '';
                // row is marked for deletion
                if ($count > 0) {
                    $where = array2where($rowdata, $this->getPkeyNames());
                    $olddata = $this->_dml_ReadBeforeUpdate($where);
                    $rowdata = $this->deleteRecord($olddata[0]);
                } // if
            } // if

            if ($this->errors) {
                $errors[$rownum] = $this->errors;
            } // if

        } // foreach

        // perform any custom post-update processing
        $fieldarray = $this->_cm_post_updateLinkData($fieldarray, $postarray);
        if (!empty($this->errors)) {
            $errors = array_merge($errors, $this->errors);
            return $fieldarray;
        } // if

        $this->errors = $errors;
        $this->fieldarray = $fieldarray;

        return $fieldarray;

    } // updateLinkData

    // ****************************************************************************
    function updateMultiple ($fieldarray, $postarray=array())
    // update multiple records using original data in $fieldarray
    // and changed data in $postarray.
    {
        //DebugBreak();
        $this->errors = array();
        $count = 0;

        // transfer values from $postarray to $fieldarray
        // each fieldname in $postarray is an array of values
        foreach ($postarray as $fieldname => $valuearray) {
            if (is_array($valuearray)) {
                // copy row value from $postarray to $fieldarray for current $fieldname
                foreach ($valuearray as $row => $value) {
                    // $fieldarray starts at 0, $postarray starts at 1
                    $fieldarray[$row-1][$fieldname] = $postarray[$fieldname][$row];
                } // foreach
            } // if
        } // foreach

        // perform custom processing before any database update
        $fieldarray = $this->_cm_pre_updateMultiple($fieldarray);

        $this->via_updateMultiple = true;
        if (empty($this->errors)) {
            // create a separate array indexed by row number
            $errors = array();
            // now update each row in the database
            foreach ($fieldarray as $row => $data) {
                $fieldarray[$row] = $this->updateRecord($fieldarray[$row]);
                if (!empty($this->errors)) {
                    // keep $errors separate for each row
                    $errors[$row] = $this->errors;
                } else {
                    $count = $count + $this->numrows;
                } // if
            } // foreach
            // overwrite proper array
            $this->errors = $errors;
        } // if
        $this->via_updateMultiple = false;

        $this->messages[] = getLanguageText('sys0006', $count, strtoupper($this->tablename)); // '$count records were updated in $ablename'

        if (empty($this->errors)) {
            // perform custom processing after any database update
            $fieldarray = $this->_cm_post_updateMultiple($fieldarray);
        } // if

        // store updated $fieldarray within this object
        $this->fieldarray = $fieldarray;

        return $fieldarray;

    } // updateMultiple

    // ****************************************************************************
    function updateRecord ($fieldarray)
    // update a record using the contents of $fieldarray.
    {
        //DebugBreak();
        if (empty($fieldarray)) return $fieldarray;

        if (!is_string(key($fieldarray))) {
            // input is indexed by row, so extract data for 1st row only
            $fieldarray = $fieldarray[key($fieldarray)];
        } // if

        $this->errors = array();

        // perform any custom pre-update processing
        $fieldarray = $this->_cm_pre_updateRecord($fieldarray);

        if (empty($this->errors)) {
            // perform standard declarative checks on input data
            $updatearray = $this->validateUpdate($fieldarray);
        } // if

        if (empty($this->errors)) {
            // build 'where' string using values for primary key
            $where = array2where($updatearray, $this->getPkeyNames());
            // obtain copy of original record from database
            $originaldata = $this->_dml_ReadBeforeUpdate($where);
            if ($this->numrows <> 1) {
                // 'Could not locate original $tablename record for updating $where'
                $this->errors[] = getLanguageText('sys0007', strtoupper($this->tablename), $where);
            } else {
                // use only 1st row in $originaldata
                $originaldata = $originaldata[key($originaldata)];
                // insert values missing from update array before validation
                $updatearray = array_merge($originaldata, $updatearray);
            } // if
        } // if

        if (empty($this->errors)) {
            if ($this->skip_validation) {
                // do not perform any custom validation
            } else {
                // perform any custom validation/processing before update
                $updatearray = $this->_cm_commonValidation($updatearray, $originaldata);
                if (empty($this->errors)) {
                    $updatearray = $this->_cm_validateUpdate($updatearray, $originaldata);
                } // if
            } // if
        } // if

        // remove any autoinsert or autoupdate fields
        foreach ($this->fieldspec as $field => $spec) {
            if (array_key_exists('autoinsert', $spec)) {
                // not allowed to change during update
                unset($updatearray[$field]);
            } // if
            if (array_key_exists('autoupdate', $spec)) {
                // not allowed to change during update
                unset($updatearray[$field]);
            } // if
        } // foreach

        if (empty($this->errors)) {
            // everything OK so far, so update the database
            // find out how many fields have changed
            $changes = getChanges($updatearray, $originaldata);
            if (empty($changes)) {
                $this->numrows = 0;
            } else {
                // pass both the updated and the original data for processing
                $this->_dml_updateRecord($updatearray, $originaldata);
            } // if
        } // if

        // replace any fields excluded from $updatearray
        $fieldarray = array_merge($fieldarray, $updatearray);

        if (empty($this->errors)) {
            if ($this->skip_validation) {
                // do not perform any custom processing
            } else {
                if (!empty($changes)) {
                    // perform any custom post-update processing
                    $fieldarray = $this->_cm_post_updateRecord($fieldarray, $originaldata);
                } // if
            } // if
        } // if

        // turn this flag off
        $this->skip_validation = FALSE;

        // format data for output to the user
        $fieldarray = $this->formatData($fieldarray);

        // store updated $fieldarray within this object
        $this->fieldarray = $fieldarray;

        return $fieldarray;

    } // updateRecord

    // ****************************************************************************
    function updateSelection ($selection, $replace)
    // update a selection of records in a single operation.
    {
        $this->errors = array();

        $replace = trim($replace, ' ()');

        // call custom method for specific processing
        $msg = $this->_cm_updateSelection($selection, $replace);

        return $msg;

    } // updateSelection

    // ****************************************************************************
    function updateWorkflow ($fieldarray)
    // if this task is a pending workitem then update it.
    {
        $this->errors = array();

        if ($this->dbname != 'workflow') {
            // find out if this task/context has any workflow connections,
            // and if it does then update them
            $this->_examineWorkflow($fieldarray);
        } // if

        return $this->errors;

    } // updateWorkflow

    // ****************************************************************************
    function validateDelete ($fieldarray)
    // verify that the specified record can be deleted.
    {
        //DebugBreak();
		$this->errors = array();

		if ($this->skip_validation) {
		    // skip any validation
		    return $fieldarray;
		} // if

        if (is_string($fieldarray)) {
            $fieldarray = where2array($fieldarray);
        } elseif (!is_string(key($fieldarray))) {
            // index by row, so use row zero only
            $fieldarray = $fieldarray[key($fieldarray)];
        } // if

        // invoke custom method (may be empty)
        $this->_cm_validateDelete($fieldarray);

        if (!empty($this->errors)) return $fieldarray;

        // all relationship data is held in a class variable
        foreach ($this->child_relations as $reldata) {
            $tblchild = $reldata['child'];
            switch($reldata['type']){
                case 'restricted':
                case 'RES':
                    // delete is not allowed if relationship is 'restricted'
                    $where = NULL;
                    foreach ($reldata['fields'] as $fldparent => $fldchild) {
                        if (strlen($fldchild) < 1) {
                        	$this->errors[] = getLanguageText('sys0110', strtoupper($tblchild)); // 'Name of child field missing in relationship with $tblchild';
                        	break;
                        } // if
                        $where .= "$fldchild='" .addslashes($fieldarray[$fldparent]) ."' AND ";
                    } // foreach
                    $where = rtrim($where, ' AND');
                    // instantiate an object for this table
                    if (array_key_exists('subsys_dir', $reldata)) {
                        $dir = $_SERVER['DOCUMENT_ROOT'] .getParentDIR() .'/' .$reldata['subsys_dir'] .'/';
                    } else {
                        $dir = NULL;
                    } // if
                    require_once $dir ."classes/$tblchild.class.inc";
                    $childobject = new $tblchild;
                    $count = $childobject->getCount($where);
                    unset($childobject);
                    if ($count <> 0) {
                        $this->errors[] = getLanguageText('sys0008', strtoupper($tblchild)); // 'Cannot delete - record still linked to $tblchild table'
                    } // if
                    break;
                case 'delete':
                case 'DEL':
                case 'cascade':
                case 'CAS':
                    // check children of this child
                    $where = NULL;
                    foreach ($reldata['fields'] as $fldparent => $fldchild) {
                        if (strlen($fldchild) < 1) {
                        	$this->errors[] = getLanguageText('sys0110', strtoupper($tblchild)); // 'Name of child field missing in relationship with $tblchild';
                        	break;
                        } // if
                        $where .= "$fldchild='" .addslashes($fieldarray[$fldparent]) ."' AND ";
                    } // foreach
                    $where = rtrim($where, ' AND');
                    // instantiate an object for this table
                    if (array_key_exists('subsys_dir', $reldata)) {
                        $dir = $_SERVER['DOCUMENT_ROOT'] .getParentDIR() .'/' .$reldata['subsys_dir'] .'/';
                    } else {
                        $dir = NULL;
                    } // if
                    require_once $dir ."classes/$tblchild.class.inc";
                    $childobject = new $tblchild;
                    if (array_key_exists('orderby', $reldata)) {
                    	$childobject->setOrderBy($reldata['orderby']);
                    } // if
                    $childarray  = $childobject->getdata($where);
                    foreach ($childarray as $child) {
                        $pkey   = $childobject->getPkeyArray($child);
                    	$result = $childobject->validateDelete($pkey);
                        $errors = $childobject->getErrors();
                        if (!empty($errors)) {
                            $this->errors = array_merge($this->errors, $errors);
                        } // if
                    } // foreach
                    unset($childobject);
                    break;
                case 'nullify':
                case 'NUL':
                    break;
                default:
                    $this->errors[] = getLanguageText('sys0010', $reldata['type']); // 'Unknown relation type: $type'
            } // switch
        } // foreach

		// remove any duplicate error messages
		$this->errors = array_unique($this->errors);

        return $fieldarray;

    } // validateDelete

    // ****************************************************************************
    function validateInsert ($fieldarray)
    // validate contents of $fieldarray prior to an INSERT
    {
        //DebugBreak();
        static $validationobj;

        if (!isset($validationobj)) {
            require_once 'std.validation.class.inc';
            $validationobj =& singleton::getInstance('validation_class');
        } // if

        $array = $validationobj->validateInsert($fieldarray, $this->fieldspec, $this);

        $this->errors = $validationobj->getErrors();

        return $array;

    } // validateInsert

    // ****************************************************************************
    function validateUpdate ($fieldarray)
    // validate contents of $fieldarray prior to an UPDATE
    {
        //DebugBreak();
        static $validationobj;

        if (!isset($validationobj)) {
            require_once 'std.validation.class.inc';
            $validationobj =& singleton::getInstance('validation_class');
        } // if

        $array = $validationobj->validateUpdate($fieldarray, $this->fieldspec, $this);

        $this->errors = $validationobj->getErrors();

        return $array;

    } // validateUpdate

    // ****************************************************************************
    // methods beginning with '_cm_' are designed to be customised as required
    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {

        return $fieldarray;

    } // _cm_changeConfig

    // ***************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_deleteSelection ($selection)
    // delete/update a selection of records in a single operation.
    {
        // remove this line after your customisation
        trigger_error(getLanguageText('sys0035', get_class($this)), E_USER_ERROR); // "DELETESELECTION method has not been defined in class"

        // $where must contain at least one occurrence of 'node_id='
        if (substr_count($selection, 'node_id=') < 1) {
            return getLanguageText('sys0081'); // 'Nothing has been selected yet'
        } // if

        // delete relationships by setting NODE_ID_SNR to NULL on selected records.
        $count = $this->_dml_updateSelection($selection, 'node_id_snr=NULL');

        return getLanguageText('sys0006', $count, strtoupper($this->tablename)); // $count rows were updated

    } // _cm_deleteSelection

    // ****************************************************************************
    function _cm_formatData ($fieldarray)
    // perform custom formatting before values are shown to the user.
    {

        return $fieldarray;

    } // _cm_formatData

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
    function _cm_getExtraData ($where, $fieldarray)
    // Perform custom processing for the getExtraData method.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getForeignData ($fieldarray)
    // Retrieve data from foreign (parent) tables.
    {

        return $fieldarray;

    } // _cm_getForeignData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing for the getInitialData method.
    // $fieldarray contains data from the initial $where clause.
    {

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getNodeData ($expanded, $where, $wherearray)
    // retrieve requested node data from the database.
    // $expanded may be a list of nodes to be expanded, or 'ALL' nodes.
    // $where may contain specific selection criteria as a string.
    // $wherearray is $where but converted into an array.
    {
        //DebugBreak();
        $this->sql_select  = '';
        $this->sql_from    = '';
        $this->sql_where   = '';
        $this->sql_groupby = '';
        $this->sql_having  = '';

        if (array_key_exists('tree_type_id', $wherearray)) {
            // look for root nodes within this tree_type
            $wherearray['tree_level_seq'] = 1;
            $where = array2where($wherearray);
        } // if

        $data_raw = $this->getData($where);

        foreach ($data_raw as $row => $rowdata) {
            // append data for current node to output array
            $fieldarray[] = $this->formatData($rowdata);
            $node_id      = $rowdata['node_id'];
            if ($rowdata['child_count'] > 0) {
                // child nodes exist, but do we expand them?
                if (array_key_exists($node_id, $expanded) | $expanded == 'ALL') {
                    // tell system this row has been expanded
                    $fieldarray[count($fieldarray)-1]['expanded'] = 'y';
                    // this replaces 'ALL' with a list of actual nodes
                    $this->expanded[$node_id] = TRUE;
                    // get the child nodes belonging to this parent node
                    $childdata = $this->getNodeData($expanded, "node_id_snr='$node_id'");
                    // add in child data after the parent
                    $fieldarray = array_merge($fieldarray, $childdata);
                } else {
                    unset($this->expanded[$node_id]);
                } // if
            } // if
        } // foreach

        unset($data_raw);

        return $fieldarray;

    } // _cm_getNodeData

    // ****************************************************************************
    function _cm_getValRep ($item='')
    // get Value/Representation list as an associative array.
    {
        $array = array();

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_initialise ($where, $selection)
    // perform any initialisation for the current task.
    {
        // customisable code goes here

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_popupCall ($popupname, $where, $fieldarray, &$settings)
    // if a popup button has been pressed the contents of $where may need to
    // be altered before the popup screen is called.
    // NOTE: $settings is passed BY REFERENCE as it may be altered as well.
    {
        // the default is to clear out the contents of $where
        $where = '';

        //if ($popupname == '???_popup') {
        //   // replace $where for this popup
        //   $where = "???_id='ORG'";
        //} // if

        // ensure that only one entry can be selected
        // (multiple entries may be defined by separating them with '&')
        $settings = 'select_one=true';

        return $where;

    } // _cm_popupCall

    // ****************************************************************************
    function _cm_popupReturn ($fieldarray, $return_from, $selection)
    // process a selection returned from a popup screen.
    // $fieldarray contains the record data when the popup button was pressed.
    // $return_from identifies which popup screen was called.
    // $selection contains an array of item(s) selected in that popup screen.
    {

        //if ($return_from == '???_popup.php') {
        //   // get description for selected item
        //   include_once 'classes/???.class.inc';
        //   $dbobject = new ???;
        //   $dbobject->sql_select = '???_id, ???_desc';
        //   $foreign_data = $dbobject->getData($selection);
        //   // merge with existing data
        //   $fieldarray = array_merge($fieldarray, $foreign_data[0]);
        //   unset($dbobject);
        //   if ($GLOBALS['mode'] != 'search') {
        //      // redo any custom initialisation
        //      $fieldarray = $this->_cm_getInitialData($fieldarray);
        //   } // if
        //} // if

        return $fieldarray;

    } // _cm_popupReturn

    // ****************************************************************************
    function _cm_post_deleteRecord ($fieldarray)
    // perform custom processing after database record has been deleted.
    {

        return $fieldarray;

    } // _cm_post_deleteRecord

    // ****************************************************************************
    function _cm_post_eraseRecord ($fieldarray)
    // perform custom processing after database record has been erased.
    {

        return $fieldarray;

    } // _cm_post_eraseRecord

    // ****************************************************************************
    function _cm_post_getData ($rowdata, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {

        return $rowdata;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_post_insertMultiple ($fieldarray)
    // perform custom processing after multiple database records are inserted.
    {

        return $fieldarray;

    } // _cm_post_insertMultiple

    // ****************************************************************************
    function _cm_post_insertRecord ($fieldarray)
    // perform custom processing after database record has been inserted.
    {

        return $fieldarray;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_post_updateLinkdata ($fieldarray, $postarray)
    // perform custom processing after multiple database records have been updated.
    {

        return $fieldarray;

    } // _cm_post_updateLinkData

    // ****************************************************************************
    function _cm_post_updateMultiple ($fieldarray)
    // perform custom processing after multiple database records have been updated.
    {
        return $fieldarray;

    } // _cm_post_updateMultiple

    // ****************************************************************************
    function _cm_post_updateRecord ($fieldarray, $old_data)
    // perform custom processing after database record is updated.
    {

        return $fieldarray;

    } // _cm_post_updateRecord

    // ****************************************************************************
    function _cm_pre_deleteRecord ($fieldarray)
    // perform custom processing before database record is deleted.
    {

        return $fieldarray;

    } // _cm_pre_deleteRecord

    // ****************************************************************************
    function _cm_pre_eraseRecord ($fieldarray)
    // perform custom processing before database record is erased.
    {

        return $fieldarray;

    } // _cm_pre_eraseRecord

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    {
        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_insertMultiple ($fieldarray)
    // perform custom processing before multiple database records are inserted.
    {

        return $fieldarray;

    } // _cm_pre_insertMultiple

    // ****************************************************************************
    function _cm_pre_insertRecord ($fieldarray)
    // perform custom processing before database record is inserted.
    {

        return $fieldarray;

    } // _cm_pre_insertRecord

    // ****************************************************************************
    function _cm_pre_updateLinkdata ($fieldarray, &$postarray)
    // $fieldarray is an array of field data (multiple rows).
    // $select is an array of entries which have been selected.
    // NOTE: $postarray is passed BY REFERENCE so that it may be modified.
    // NOTE: $fieldarray starts at 0, $select starts at 1.
    {

        return $fieldarray;

    } // _cm_pre_updateLinkData

    // ****************************************************************************
    function _cm_pre_updateMultiple ($fieldarray)
    // perform custom processing before multiple database records are updated.
    {
        return $fieldarray;

    } // _cm_pre_updateMultiple

    // ****************************************************************************
    function _cm_pre_updateRecord ($fieldarray)
    // perform custom processing before database record is updated.
    // errors are added to $this->errors.
    {
        //$this->row_locks = 'SH';    // shared
        //$this->row_locks = 'EX';    // exclusive

        return $fieldarray;

    } // _cm_pre_updateRecord

    // ****************************************************************************
    function _cm_setScrollArray ($where, $where_array)
    // construct an array of primary keys to scroll through
    {
        $array = array();

        $array = splitWhereByRow($where);    // default - replace with custom code

        return $array;

    } // _cm_setScrollArray

    // ****************************************************************************
    function _cm_unFormatData ($fieldarray)
    // remove custom formatting before values are passed to the database.
    {

        return $fieldarray;

    } // _cm_unFormatData

    // ****************************************************************************
    function _cm_updateSelection ($selection, $replace)
    // update multiple rows in a single operation.
    {
        // remove this line after your customisation
        //trigger_error("UPDATESELECTION method has not been defined in class" .get_class($this), E_USER_ERROR);

        $count = $this->_dml_updateSelection($selection, $replace);

        return getLanguageText('sys0006', $count, strtoupper($this->tablename)); // ' $count records were updated in $tablename'

    } // _cm_updateSelection

    // ****************************************************************************
    function _cm_validateDelete ($fieldarray)
    // verify that the selected record can be deleted.
    // (put any errors in $this->errors)
    {

        return;

    } // _cm_validateDelete

    // ****************************************************************************
    function _cm_validateInsert ($fieldarray)
    // perform custom validation before insert.
    {

        return $fieldarray;

    } // _cm_validateInsert

    // ****************************************************************************
    function _cm_validateUpdate ($fieldarray, $originaldata)
    // perform custom validation before update.
    {

        return $fieldarray;

    } // _cm_validateUpdate

    // ****************************************************************************
    // methods beginning with '_ddl_' are for calling the Database Access object
    // (for commands using the Data Definition Language)
    // ****************************************************************************
    function _ddl_getColumnSpecs ()
    // obtain column specifications.
    {
        //DebugBreak();
        $DDL =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $array = $DDL->ddl_getColumnSpecs();

        return $array;

    } // _ddl_getColumnSpecs

    // ****************************************************************************
    function _ddl_showColumns($dbname, $tablename)
    // obtain a list of column names for the selected database table.
    {
        //DebugBreak();
        $DDL =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $array = $DDL->ddl_showColumns($dbname, $tablename);

        return $array;

    } // _ddl_showColumns

    // ****************************************************************************
    function _ddl_showCreateTable ($dbname, $tablename)
    // obtain a list of column names for the selected database table.
    {
        //DebugBreak();
        $DDL =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $array = $DDL->ddl_showCreateTable($dbname, $tablename);

        return $array;

    } // _ddl_showCreateTable

    // ****************************************************************************
    function _ddl_showDatabases ()
    // obtain a list of existing database names.
    {
        //DebugBreak();
        $DDL =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $array = $DDL->ddl_showDatabases();

        return $array;

    } // _ddl_showDatabases

    // ****************************************************************************
    function _ddl_showTables ($dbname)
    // obtain a list of table names for the selected database.
    {
        //DebugBreak();
        $DDL =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $array = $DDL->ddl_showTables($dbname);

        return $array;

    } // _ddl_showTables

    // ****************************************************************************
    function _ddl_showTableKeys ($dbname, $tablename)
    // obtain a list of existing database names.
    {
        //DebugBreak();
        $DDL =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $array = $DDL->ddl_showTableKeys($dbname, $tablename);

        return $array;

    } // _ddl_showTableKeys

    // ****************************************************************************
    // methods beginning with '_dml_' are for calling the Database Access object
    // (for commands using the Data Manipulation Language)
    // ****************************************************************************
    function _dml_deleteRecord ($fieldarray)
    // delete the record whose primary key is contained within $fieldarray.
    {
        //DebugBreak();
        $DML =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $DML->fieldspec     = $this->fieldspec;
        $DML->audit_logging = $this->audit_logging;

        $DML->primary_key   = $this->getPkeyNames();

        $DML->deleteRecord($this->dbname, $this->tablename, $fieldarray);

        $this->errors  = array_merge($DML->getErrors(), $this->errors);
        $this->numrows = $DML->getNumRows();

        return;

    } // _dml_deleteRecord

    // ****************************************************************************
    function _dml_deleteSelection ($selection)
    // delete a selection of records in a single operation.
    {
        //DebugBreak();
        $DML =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $DML->fieldspec     = $this->fieldspec;
        $DML->audit_logging = $this->audit_logging;

        $count = $DML->deleteSelection($this->dbname, $this->tablename, $selection);

        $this->errors = array_merge($DML->getErrors(), $this->errors);

        return $count;

    } // _dml_deleteSelection

    // ****************************************************************************
    function _dml_getCount ($where)
    // Get count of recors which match criteria in $where.
    {
        //DebugBreak();
        $DML =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $count = $DML->getCount($this->dbname, $this->tablename, $where);

        $this->errors = array_merge($DML->getErrors(), $this->errors);

        return $count;

    } // _dml_getCount

    // ****************************************************************************
    function _dml_getData ($where)
    // Get data from the specified database table.
    // Results may be affected by $where and $pageno.
    {
        //DebugBreak();
        $DML =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $DML->fieldspec        = $this->fieldspec;
        $DML->pageno           = $this->pageno;
        $DML->rows_per_page    = $this->rows_per_page;
        $DML->sql_from         = $this->sql_from;
        $DML->sql_groupby      = $this->sql_groupby;
        $DML->sql_having       = $this->sql_having;
        $DML->sql_orderby      = $this->getOrderBy();
        $DML->sql_orderby_seq  = $this->getOrderBySeq();
        $DML->sql_select       = $this->sql_select;
        $DML->sql_where        = $this->sql_where;
        $DML->setRowLocks($this->row_locks);

        $array = $DML->getData($this->dbname, $this->tablename, $where);

        $this->errors   = array_merge($DML->getErrors(), $this->errors);
        $this->numrows  = $DML->getNumRows();
        $this->pageno   = $DML->getPageNo();
        $this->lastpage = $DML->getLastPage();

        return $array;

    } // _dml_getData

    // ****************************************************************************
    function _dml_getEnum ($item)
    // Get the details of an ENUM item from the database.
    {
        //DebugBreak();
        $DML =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $array = $DML->getEnum($this->dbname, $this->tablename, $item);

        $this->errors = array_merge($DML->getErrors(), $this->errors);

        return $array;

    } // _dml_getEnum

    // ****************************************************************************
    function _dml_getFunctionID ()
    // Get the function identifier for this DML class.
    {
        //DebugBreak();
        $DML =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $result = $DML->getFunctionID();

        return strtolower($result);

    } // _dml_getFunctionID

    // ****************************************************************************
    function _dml_insertRecord ($fieldarray)
    // insert a record using the contents of $fieldarray.
    {
        //DebugBreak();
        $DML =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        // use ORIGINAL, not CURRENT specifications for this database table
        $DML->fieldspec     = $this->getFieldSpec_original();
        $DML->primary_key   = $this->getPkeyNames();
        $DML->unique_keys   = $this->unique_keys;
        $DML->audit_logging = $this->audit_logging;

        $array = $DML->insertRecord($this->dbname, $this->tablename, $fieldarray);

        $this->errors = array_merge($DML->getErrors(), $this->errors);

        return $array;

    } // _dml_insertRecord

    // ****************************************************************************
    function _dml_ReadBeforeUpdate ($where)
    // Read a single record just before it is updated.
    // The primary key should be supplied in $where.

    {
        //DebugBreak();
        $DML =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $DML->fieldspec        = $this->fieldspec;
        $DML->pageno           = 1;
        $DML->rows_per_page    = 10;
        $DML->sql_from         = NULL;
        $DML->sql_groupby      = NULL;
        $DML->sql_having       = NULL;
        $DML->sql_orderby      = NULL;
        $DML->sql_orderby_seq  = NULL;
        $DML->sql_select       = NULL;
        $DML->sql_where        = NULL;
        $DML->setRowLocks('EX');   // lock this row (exclusive)

        $array = $DML->getData($this->dbname, $this->tablename, $where);

        $this->errors   = array_merge($DML->getErrors(), $this->errors);
        $this->numrows  = $DML->getNumRows();

        return $array;

    } // _dml_ReadBeforeUpdate

    // ****************************************************************************
    function _dml_updateRecord ($fieldarray, $oldarray)
    // update the record contained in $fieldarray.
    {
        $DML =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        // use ORIGINAL, not CURRENT specifications for this database table
        $DML->fieldspec     = $this->getFieldSpec_original();
        $DML->primary_key   = $this->getPkeyNames();
        $DML->unique_keys   = $this->unique_keys;
        $DML->audit_logging = $this->audit_logging;

        $DML->updateRecord($this->dbname, $this->tablename, $fieldarray, $oldarray);

        $this->errors  = array_merge($DML->getErrors(), $this->errors);
        $this->numrows = $DML->getNumRows();

        return;

    } // _dml_updateRecord

    // ****************************************************************************
    function _dml_updateSelection ($selection, $replace)
    // update a selection of records in a single operation.
    {
        //DebugBreak();
        $DML =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $DML->fieldspec     = $this->fieldspec;
        $DML->audit_logging = $this->audit_logging;

        $count = $DML->updateSelection($this->dbname, $this->tablename, $replace, $selection);

        $this->errors = array_merge($DML->getErrors(), $this->errors);

        return $count;

    } // _dml_updateSelection

    // ****************************************************************************
    function _examineWorkflow ($input)
    // a task has just completed, so ...
    // find out if this task/context starts a new workflow instance (case),
    // or is a workitem within an existing workflow instance.
    {
        //DebugBreak();
        if (is_array($input)) {
            // context is the primary key of the current record
            $context    = array2where($input, $this->getPkeyNames());
            $fieldarray = $input;
        } else {
            $context    = $input;
            $fieldarray = where2array($context);
        } // if

        $wf_case_id     = $this->wf_case_id;
        $wf_workitem_id = $this->wf_workitem_id;

        // interface with the workflow engine
        if (!class_exists('workflow_engine')) {
        	require_once 'classes/workflow_engine.class.inc';
        } // if
        $workflow =& singleton::getInstance('workflow_engine');

        // look to see if this task is a workitem within an existing workflow case
        if (isset($wf_case_id) and isset($wf_workitem_id)) {
            // yes it is, so mark it as finished
            $workflow->finishWorkItem($wf_case_id, $wf_workitem_id, $context, $fieldarray);
            if ($workflow->errors) {
                $this->errors = array_merge($this->errors, $workflow->getErrors());
                return;
            } // if
            return;
        } // if

        // look to see if this task requires the starting of a new workflow case
        $wf_case_id = $workflow->startWorkflowCase($GLOBALS['task_id'], $context);
        if ($workflow->errors) {
            $this->errors = array_merge($this->errors, $workflow->getErrors());
            return;
        } // if

        return;

    } // _examineWorkflow

    // ****************************************************************************
    function _examineWorkflowInstance ($where)
    // a task has just started, so ...
    // look to see if this task/context is a workitem within a workflow instance,
    // and if it is then set the appropriate variables (for use in finishWorkitem())
    {
        //DebugBreak();
        if (empty($where)) {
            // no context yet, so ignore
            return;
        } // if

        $this->errors = array();

        // look for a workitem that matches this task_id and context
        require_once 'classes/wf_workitem.class.inc';
        $dbworkitem =& singleton::getInstance('wf_workitem');

        $context = addslashes(trim($where, '()'));
        $workitem_where = "task_id='{$GLOBALS['task_id']}' AND context='$context' AND workitem_status='EN'";
        $workitem_data = $dbworkitem->getData($workitem_where);
        if ($dbworkitem->errors) {
            $this->errors = array_merge($this->errors, $dbworkitem->getErrors());
            return;
        } // if

        // if nothing found exit now
        if ($dbworkitem->numrows == 0) {
            return;
        } // if

        // use only first item
        $workitem_data = $workitem_data[key($workitem_data)];

        // check that workitem has been assigned to this user's role
        if ($workitem_data['role_id'] != $_SESSION['role_id']) {
            //scriptPrevious("This task has been assigned to role " .$workitem_data['role_id']);
            scriptPrevious(getLanguageText('sys0014', $workitem_data['role_id']));
        } // if

        if (empty($workitem_data['user_id'])) {
            // no user assigned to this workitem, so assign to this user
            $workitem_data['user_id'] = $_SESSION['logon_user_id'];
            $workitem_data = $dbworkitem->updateRecord($workitem_data);
            if ($dbworkitem->errors) {
                $this->errors = array_merge($this->errors, $dbworkitem->getErrors());
                return;
            } // if
        } else {
            // check that workitem has been assigned to this user
            if ($workitem_data['user_id'] != $_SESSION['logon_user_id']) {
                //scriptPrevious("This task has been assigned to user " .$workitem_data['user_id']);
                scriptPrevious(getLanguageText('sys0015', $workitem_data['user_id']));
            } // if
        } // if

        // workitem exists, so store details
        $this->wf_case_id     = $workitem_data['case_id'];
        $this->wf_workitem_id = $workitem_data['workitem_id'];

        return;

    } // _examineWorkflowInstance

    // ****************************************************************************
    function &_getDBMSengine ($engine, $dbname=null)
    // get/create the object that deals with this database engine.
    {
        if (!class_exists($engine)) {
        	// load class definition for this database engine
            if ($engine == 'mysql') {
                if (function_exists('mysqli_connect')) {
                    // use 'improved' mysql functions
                    require_once "dml.mysqli.class.inc";
                } else {
                    // use standard mysql functions
                    require_once "dml.mysql.class.inc";
                } // if
            } else {
                require_once "dml.$engine.class.inc";
            } // if
        } // if

        $DML =& singleton::getInstance($engine, $dbname);

        return $DML;

    } // _getDBMSengine

    // ****************************************************************************
    function _processInstruction ($fieldarray)
    // process instructions contained within $this->instruction
    // (as returned by a child script)
    {
        //DebugBreak();
        // look for a 'select' instruction
        if (array_key_exists('select', $this->instruction)) {
            // extract the key/value pair which has been selected
            foreach ($this->instruction['select'] as $selectkey => $selectvalue) {
                // find the row with the same key
                foreach ($fieldarray as $row => $rowdata) {
                    if ($rowdata[$selectkey] == $selectvalue) {
                        // mark this row as selected
                        $fieldarray[$row]['selected'] = 'T';
                    } // if
                } // foreach
            } // foreach
            // instruction has been processed, so remove it
            unset($this->instruction['select']);
        } // if

        // if there are no more instructions left then clear this array
        if (empty($this->instruction)) {
            unset($this->instruction);
        } // if

        return $fieldarray;

    } // _processInstruction

    // ****************************************************************************
    function __sleep ()
    // perform object clean-up before serialization
    {

        // get associative array of class variables
        $object_vars = get_object_vars($this);

        // remove/clear unwanted variables
        $object_vars['errors']   = array();
        $object_vars['messages'] = '';

        // convert to indexed array
        $object_vars = array_keys($object_vars);

        return $object_vars;

    } // __sleep

// ****************************************************************************
} // end class
// ****************************************************************************

?>
