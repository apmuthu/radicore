<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2007 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

class Default_Table
{
    // member variables
    var $allow_empty_where = false;     // switch to allow an empty $where string in STD.LIST2.INC
    var $audit_logging = false;         // yes/no switch
    var $checkPrimaryKey = false;       // yes/no switch
    var $child_relations = array();     // child relationship specifications (optional)
    var $css_files = array();           // optional CSS file names
    var $dbms_engine;                   // database engine (mysql, postgresql, oracle, etc)
    var $dbname;                        // database name
    var $dirname;                       // directory name of current script

    var $download_filename;             // file to be downloaded
    var $download_mode;                 // 'inline' or null

    var $errors = array();              // array of errors
    var $expanded;                      // list of tree nodes which have been expanded
    var $fieldarray;                    // array of row/field data
    var $fieldspec = array();           // field specifications (see class constructor)
    var $field_access;                  // see setFieldAccess()
    var $ignore_empty_fields = false;   // YES/NO switch (see getInitialData() method)
    var $inner_table;                   // used in an outer-link-inner relationship
    var $instruction;                   // instruction to be passed to previous script
    var $is_link_table = FALSE;         // used in method _sqlAssembleWhere (many-link-many relationship)
    var $javascript = array();          // optional JavaScript code
    var $lastpage;                      // last available page number in current query
    var $link_item;                     // used in _sqlAssembleWhere() in many-to-many relationships
    var $lookup_data = array();         // array of lookup data (for dropdowns, radio groups)
    var $messages = array();            // array of messages
    var $numrows;                       // number of rows retrieved
    var $outer_table;                   // used in an outer-link-inner relationship
    var $pageno;                        // requested page number
    var $parent_relations = array();    // parent relationship specifications (optional)

    var $picker_subdir;                 // subdirectory for the File Picker
    var $picker_filetypes = array();    // array of file types

    var $primary_key = array();         // column(s) which form the primary key
    var $rows_per_page = 0;             // page size for multi-row forms
    var $row_locks;                     // FALSE, SH=shared, EX=exclusive
    var $row_locks_supp;                // supplemental lock type
    var $scrollarray;                   // array for internal scrolling
    var $scrollindex;                   // index to current item in scrollarray
    var $selectall = false;             // TRUE or FALSE (refer to setAction() method)
    var $skip_getdata = false;          // YES/NO switch
    var $skip_validation = false;       // YES/NO switch
    var $tablename;                     // table name (internal)
    var $transaction_level;             // transaction level
    var $unique_keys = array();         // unique key specifications (optional)

    var $upload_subdir;                 // subdirectory for file upoads
    var $upload_filetypes = array();    // file types for uploading
    var $upload_maxfilesize;            // max file size for uploading

    var $wf_case_id;                    // workflow case id
    var $wf_context;                    // workitem context
    var $wf_workitem_id;                // workflow workitem id

    var $xsl_params = array();          // optional parameters to be pased to XSL transformation

    // the following are used to construct SQL queries
    var $default_orderby = null;        // default, may be overridden by $sql_orderby
    var $sql_from;
    var $sql_groupby;
    var $sql_having;
    var $sql_orderby;                   // sort field
    var $sql_orderby_seq;               // 'asc' or 'desc'
    var $sql_orderby_table;             // tablename qualifier for optional sort criteria
    var $sql_search;                    // optional search criteria from a search screen
    var $sql_search_table;              // tablename qualifier for optional search criteria
    var $sql_select;                    // fields to be selected
    var $sql_where;                     // additional selection criteria
    var $where;                         // passed from parent form

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function Default_Table ()
    {
        // save directory name of current script
        //$this->dirname   = dirname(__file__);

        $this->dbms_engine = $GLOBALS['dbms'];
        $this->tablename   = 'default';
        $this->dbname      = 'default';

        // call this method to get original field specifications
        // (note that they may be modified at runtime)
        $this->fieldspec = $this->getFieldSpec_original();

    } // Default_Table

    // ****************************************************************************
    function array2string ($array)
    // return an array of values (for a SET/ARRAY/VARRAY datatype) as a string.
    // NOTE: the format of the string is dependent upon the DBMS.
    {
        $DML =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $string = $DML->array2string($array);

        return $string;

    } // array2string

    // ****************************************************************************
    function cascadeDelete ($where)
    // Parent record is being deleted, so remove associated records from this table.
    {
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
    // initialise all editable fields in $fieldarray.
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
            } else {
                $fieldarray[$field] = NULL;
            } // if
        } // foreach

        $this->fieldarray = $fieldarray;

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
        $errors = array();

        if ($this->dbname != 'workflow' AND $this->dbname != 'audit') {
            // if this task+context is a pending workitem then update it
            $errors = $this->_examineWorkflow($this->fieldarray);
        } // if

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

        if (isset($GLOBALS['batch']) AND is_True($GLOBALS['batch'])) {
        	// check to see if this task is a pending workitem
            $errors = $this->checkWorkflow($fieldarray[0]);
            if ($errors) {
                return $fieldarray;
            } // if
        } // if

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
        $this->errors = array();   // initialise

        if (is_string($fieldarray)) {
            // convert from string to array
            $fieldarray = where2array($fieldarray, false, false);
        } // if

        // strip any operators from the value portion of the array
        $fieldarray = stripOperators($fieldarray);

        // shift all field names to lower case
        $fieldarray = array_change_key_case($fieldarray, CASE_LOWER);

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
                unset($fieldarray[$field]);
            } // if
        } // foreach

        if (empty($this->errors)) {
            $where = array2where($fieldarray, $this->getPkeyNames());
            // obtain copy of original record from database
            $originaldata = $this->_dml_ReadBeforeUpdate($where);
            if ($this->numrows > 0) {
                // use only 1st row in $originaldata
                $originaldata = $originaldata[0];
                // insert non-key values for inclusion in audit log
                $fieldarray = array_merge($fieldarray, $originaldata);
            } // if
        } // if

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
                    if (!class_exists($tblchild)) {
                        require_once $dir ."classes/$tblchild.class.inc";
                    } // if
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
                    if (!class_exists($tblchild)) {
                        require_once $dir ."classes/$tblchild.class.inc";
                    } // if
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
        $this->errors = array();

        // call custom method for specific processig
        $msg = $this->_cm_deleteSelection($selection);

        return $msg;

    } // deleteSelection

    // ****************************************************************************
    function eraseRecord ($fieldarray)
    // delete the record, and ALL its children, specified in $fieldarray.
    {
        $this->errors = array();   // initialise

        if (is_string($fieldarray)) {
            // convert from string to array
            $fieldarray = where2array($fieldarray, false, false);
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
                    if (!class_exists($tblchild)) {
                        require_once $dir ."classes/$tblchild.class.inc";
                    } // if
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
    function fetchRow ($resource)
    // Fetch the next row from a resource created in the getData_batch() method.
    {
        $this->errors = array();

        $DML =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $row = $DML->fetchRow($this->dbname, $resource);

        if ($row) {
        	// perform any custom post-retrieve processing
        	$array[0] = $row;
            $array = $this->_cm_post_getData($array, $this->where);
            $row = $array[0];
        } // if

        return $row;

    } // fetchRow

    // ****************************************************************************
    function fileUpload ($input_name, $temp_file)
    // Specify file name to be used for the upload.
    {
        $this->errors = array();

        $fieldarray = where2array($this->where);

        $output_name = $this->_cm_fileUpload($input_name, $temp_file, $fieldarray);

        return $this->upload_subdir .'/' .$output_name;

    } // fileUpload

    // ****************************************************************************
    function formatData ($fieldarray, &$css_array)
    // format values retrieved from the database before they are shown to the user.
    // (such as changing dates from 'CCYY-MM-DD' to 'dd Mmm CCYY'
    // Note: $css_array is passed BY REFERENCE as it may be altered.
    {
        $dateobj =& singleton::getInstance('date_class');

        foreach ($fieldarray as $fieldname => $fieldvalue) {
            // only deal with fields defined in $fieldspec
            if (isset($this->fieldspec[$fieldname])) {
                // get specifications for current field
                $fieldspec = $this->fieldspec[$fieldname];
                if (!isset($fieldspec['type'])) {
                    $fieldspec['type'] = 'string';  // set default type
                } // if

                if ($GLOBALS['mode'] == 'search') {
                	if (preg_match("/^(<>|<=|<|>=|>|!=|=)/", $fieldvalue, $regs )) {
                        $operator = $regs[0];
                        $fieldvalue = ltrim($fieldvalue, $operator);
                    } else {
                        $operator = '=';
                    } // if
                } else {
                    $operator = '+';
                } // if

                switch (strtolower($fieldspec['type'])) {
                    case 'string':
                        // do nothing
                        break;
                    case 'set':
                    case 'array':
                        if (!is_array($fieldvalue)) {
                        	// convert string into an array
                            if (strlen($fieldvalue) > 0) {
                                // note: postgresql uses '{}' to enclose the array
                            	$fieldvalue = explode(',', trim($fieldvalue, '{}'));
                            } else {
                                $fieldvalue = array();
                            } // if
                        } // if
                        break;
                    case 'boolean':
                        if (is_bool($fieldvalue) or strlen($fieldvalue) > 0) {
                            $boolean = getLanguageArray('boolean');
                        	// set boolean fields to either TRUE or FALSE
                            if (is_True($fieldvalue)) {
                                if (isset($fieldspec['true'])) {
                                    $fieldvalue = $fieldspec['true'];
                                } elseif (isset($boolean['true'])) {
                                	$fieldvalue = $boolean['true'];
                                } // if
                            } else {
                                if (isset($fieldspec['false'])) {
                                    $fieldvalue = $fieldspec['false'];
                                } elseif (isset($boolean['false'])) {
                                	$fieldvalue = $boolean['false'];
                                } // if
                            } // if
                        } else {
                            // value has not defined yet
                            if ($GLOBALS['mode'] != 'search') {
                                if (isset($fieldspec['default'])) {
                                	// default value has been defined, so use it
                                    $fieldvalue = $fieldspec['default'];
                                } // if
                            } else {
                                // leave as undefined
                            } // if
                        } // if
                        break;
                    case 'date':
                        if (isset($fieldspec['infinityisnull']) and substr($fieldvalue, 0, 10) == '9999-12-31') {
                            // this date is shown to the user as empty
                            $fieldvalue = '';
                        } else {
                            if ($GLOBALS['mode'] == 'search' and strpos($fieldvalue, '%')) {
                                // this is already in LIKE format for a seach screen. so leave it alone
                                // (apart from removing trailing '%' which will be replaced later)
                                $fieldvalue = rtrim($fieldvalue, '%');
                            } else {
                                // convert date from internal to external format
                                $fieldvalue = $dateobj->getExternalDate($fieldvalue);
                            } // if
                        } // if
                        break;
                    case 'datetime':
                    case 'timestamp':
                        if (isset($fieldspec['infinityisnull']) and substr($fieldvalue, 0, 10) == '9999-12-31') {
                            // this date is shown to the user as empty
                            $fieldvalue = '';
                        } else {
                            if (!empty($fieldvalue)) {
                                // convert date from internal to external format
                                list($date, $time) = explode(' ', $fieldvalue);
                                if ($date = $dateobj->getExternalDate($date)) {
                                    $fieldvalue = trim($date) .' ' .substr($time, 0, 8);
                                } else {
                                    // date is empty, so return empty time as well
                                    $fieldvalue = '';
                                } // if
                            } // if
                        } // if
                        break;
                    case 'time':
                        if (isset($fieldspec['size']) and $fieldspec['size'] == 5) {
                            // exclude the seconds portion of the time
                            $fieldvalue = substr($fieldarray[$fieldname], 0, 5);
                        } // if
                        break;
                    case 'double':
                    case 'float':
                    case 'real':
                        if (!empty($fieldvalue)) {
                            if (is_numeric($fieldvalue)) {
                                $float = sprintf('%F', $fieldvalue);
                                $float = rtrim($float,'0');  // remove trailing zeroes after decimal point
                                $float = rtrim($float,'.');  // remove decimal point if it is the last character
                                if (strlen($float) > 18) {
                                	$fieldvalue = (double)$fieldvalue;    // number is too long, so display in scientific notation
                                } else {
                                    $fieldvalue = $float;                 // display as decimal number
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
                       break;
                    default:
                        ;
                } // switch

                if (eregi('^(csv|pdf)', strtolower($GLOBALS['mode']))) {
                	if (isset($fieldspec['optionlist'])) {
                	    if (!empty($fieldvalue)) {
                	    	// convert value into corresponding entry(s) from optionlist
                            if (isset($this->lookup_data[$fieldspec['optionlist']])) {
                            	$lookup = $this->lookup_data[$fieldspec['optionlist']];
                                if (!empty($lookup)) {
                            		if (is_array($fieldvalue)) {
                                		// convert array into a comma separated string
                                		$string = '';
                                		foreach ($fieldvalue as $key) {
                                			$string .= $lookup[$key] .',';
                                		} // foreach
                                		$fieldvalue = rtrim($string, ',');
                                	} else {
                                	    $fieldvalue = $lookup[$fieldvalue];
                                	} // if
                            	} // if
                            } // if
                	    } // if
                    } elseif (isset($fieldspec['foreign_field'])) {
                        if (isset($fieldarray[$fieldspec['foreign_field']])) {
                        	$fieldvalue = $fieldarray[$fieldspec['foreign_field']];
                        } // if
                    } // if
                } // if

                if (isset($fieldspec['password'])) {
                    if (isset($fieldspec['hash'])) {
                        if (ereg('sha1|md5', $fieldspec['hash'])) {
                            // for this hash type do not output anything
                            $fieldvalue = '';
                        } // if
                    } // if
                } // if

                // put changed value back into array
                if ($GLOBALS['mode'] == 'search' AND $operator != '=') {
                    $fieldarray[$fieldname] = $operator.$fieldvalue;
                } else {
                    $fieldarray[$fieldname] = $fieldvalue;
                } // if

            } // if
        } // foreach

        // perform any custom formatting
        $fieldarray = $this->_cm_formatData($fieldarray, $css_array);

        return $fieldarray;

    } // formatData

    // ****************************************************************************
    function getClassName ()
    // return the name of this class, but without any numeric suffix.
    // Example: table 'mnu_tran' may have subtypes (aliases) of 'mnu_tran_s01'
    // and 'mnu_tran_jnr'. These will return the following:
    // 'mnu_task'     -> 'mnu_task'
    // 'mnu_task_s01' -> 'mnu_task'
    // 'mnu_task_jnr' -> 'mnu_task_jnr'
    {
        $tablename = removeTableSuffix(get_class($this));

        return strtolower($tablename);

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
    function getData ($where=null)
    // get data from this table using optional 'where' criteria.
    // this is formatted before being displayed to the user.
    {
        $this->errors = array();    // initialise

        if (!empty($this->sql_where)) {
            $this->sql_where = whereFilterWhere($where, $this->sql_where);
        } // if

        $this->where = $where;      // save

        if (is_null($this->pageno)) {
            $this->pageno = 1;      //default
        } // if

        // convert $where from string to an associative array
        $where_array = where2array($where, $this->pageno);

        // make this data available if passed down by parent object
        if (empty($this->fieldarray)) {
        	$fieldarray = array();
        } else {
            if (is_string(key($this->fieldarray))) {
            	$fieldarray = $this->fieldarray;
            } else {
                $fieldarray = $this->fieldarray[key($this->fieldarray)];
            } // if
        } // if

        // perform any custom pre-retrieve processing
        $where = $this->_cm_pre_getData($where, $where_array, $fieldarray);
        if ($this->errors) return;

        if ($this->where != $where) {
            // $where has been modified, so update $where_array
            $this->where = $where;
            $where_array = where2array($where, $this->pageno);
        } // if

        if ($this->checkPrimaryKey) {
            if (!empty($this->sql_where)) {
                // temporarily combine these two arrays
            	$sql_where_array = where2array($this->sql_where, false, false);
            	$where_array2 = array_merge($where_array, $sql_where_array);
            } else {
                $where_array2 = $where_array;
            } // if
            $this->errors = isPkeyComplete($where_array2, $this->getPkeyNames());
            if ($this->errors) return;
            $this->checkPrimaryKey = false;
        } // if

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
            // assemble the $where string from its component parts
            $where_str = $this->_sqlAssembleWhere($where, $where_array);

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
            $this->where = $where;
        } // if

        // perform any formatting on the raw data
        $this->fieldarray = array();
        foreach ($data_raw as $rowdata) {
//            if ($this->selectall) {
//                // switch has been set (see setAction() method), so mark this row as 'selected'
//                $rowdata['selected'] = true;
//            } // if
            $this->fieldarray[] = $rowdata;
        } // foreach

        return $this->fieldarray;

    } // getData

    // ****************************************************************************
    function getData_batch ($where=null)
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

        $result = $DML->getData_batch($this->dbname, $this->tablename, $where);

        $this->numrows  = $DML->getNumRows();

        return $result;

    } // getData_batch

    // ****************************************************************************
    function getData_raw ($where=null)
    // get data from this table using optional 'where' criteria.
    // this is returned raw (as read from the database with any formatting).
    {
        $this->errors = array();

        if (!empty($this->sql_where)) {
        	if (empty($where)) {
        		$where = $this->sql_where;
        	} else {
        	    $where = "$where AND $this->sql_where";
        	} // if
        } // if

        $data_raw = $this->_dml_getData($where);

        return $data_raw;

    } // getData_raw

    // ****************************************************************************
    function getData_serial ($where=null)
    // get data from this table using optional 'where' criteria.
    // this does not return the records one page at a time but allows a serial
    // read of all records for processing in another way, such as exporting to CSV.
    {
        $this->errors = array();    // initialise

        $this->where = $where;      // save

        // convert $where from string to an associative array
        $where_array = where2array($where, $this->pageno);

        // perform any custom pre-retrieve processing
        $where = $this->_cm_pre_getData($where, $where_array);
        if ($this->errors) return;

        if ($this->where != $where) {
            // $where has been modified, so update $where_array
            $this->where = $where;
            $where_array = where2array($where, $this->pageno);
        } // if

        if ($this->checkPrimaryKey) {
            $this->errors = isPkeyComplete($where_array, $this->getPkeyNames());
            if ($this->errors) return;
            $this->checkPrimaryKey = false;
        } // if

        // assemble the $where string from its component parts
        $where_str = $this->_sqlAssembleWhere($where, $where_array);

        // get the result from the database
        $result = $this->getData_batch($where_str);

        return $result;

    } // getData_serial

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
        if (!is_array($this->errors)) {
            // convert string into an array
            $this->errors = (array)$this->errors;
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
        if (empty($input)) {
            $fieldarray[0] = array();
            $key           = 0;
            $where         = null;
        } elseif (is_string($input)) {
            // convert from string to associative array
            $fieldarray[0] = where2array($input);
            $key           = 0;
            $where         = $input;
        } else {
            reset($input);   // fix for version 4.4.1
            if (is_string(key($input))) {
                // associative array, so set it to row zero
                $fieldarray[0] = $input;
                $key           = 0;
            } else {
                // indexed by row, so use it as-is
                $fieldarray = $input;
                $key        = key($input);
            } // if
            // convert first row in $fieldarray to a string
            $where = array2where($fieldarray[$key]);
        } // if

        // change current table configuraton (optional)
        $fieldarray[$key] = $this->_cm_changeConfig($where, $fieldarray[$key]);

        // perform custom processing (such as obtaining lookup lists)
        $fieldarray[$key] = $this->_cm_getExtraData($where, $fieldarray[$key]);

        // retrieve data from foreign (parent) tables for each row
        foreach ($fieldarray as $rownum => $rowdata) {
        	$fieldarray[$rownum] = $this->getForeignData($rowdata);
        } // foreach

        // store updated $fieldarray within this object
        $this->fieldarray = $fieldarray;

        if ($this->dbname != 'workflow' and $GLOBALS['mode'] == 'update') {
            // rebuild $where to ensure it contains pkey fields only
            $where = array2where ($fieldarray[$key], $this->getPkeyNames());
            // find out if this task/context is a workitem within a workflow instance
            $this->_examineWorkflowInstance($where);
        } // if

        if (count($fieldarray) > 1) {
            // return all rows as an indexed array
            return $fieldarray;
        } else {
            // return only row as an associative array
            return $fieldarray[0];
        } // if

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
                list($original, $alias) = getTableAlias3($parent_field);
                if (!empty($alias)) {
                	$parent_field = trim($alias);
                } // if
                if (isset($fieldarray[$parent_field])) {
                    // field is already there, so do nothing
                } else {
                    // construct WHERE clause to read from parent table
                    $where = '';
                    foreach ($reldata['fields'] as $fldchild => $fldparent) {
                        if (strlen($fldchild) < 1) {
                            // 'Name of child field missing in relationship with $tblchild'
                            $this->errors[] = getLanguageText('sys0110', strtoupper($tblchild));
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
                            // merge with existing data (without overwriting existing values)
                            $fieldarray = array_merge($parent_data[0], $fieldarray);
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

        // perform any custom processing (optional)
        $fieldarray = $this->_cm_getInitialData($fieldarray);
        if ($this->errors) {
            return $fieldarray;
        } // if

        // do not display autoinsert/autoupdate fields on input screens
        foreach ($this->fieldspec as $field => $spec) {
            if (array_key_exists('autoinsert', $spec) or array_key_exists('autoupdate', $spec)) {
                $this->fieldspec[$field]['nodisplay'] = 'y';
            } // if
        } // foreach

        reset($fieldarray);  // fix to enable key($fieldarray) to work
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
    function getInitialDataMultiple ($where)
    // get initial data for new records in this table.
    // this is called before insertMultiple(), so there is no user dialog.
    {
        $this->errors = array();
        $this->numrows = 0;

        if (!empty($where)) {
            if (is_array($where)) {
                $fieldarray = $where;
            } else {
                // convert 'where' string to an associative array
                $fieldarray = where2array($where);
            } // if
        } else {
            $fieldarray = array();
        } // if

        // perform any custom processing (optional)
        $fieldarray = $this->_cm_getInitialDataMultiple($fieldarray);
        if ($this->errors) {
            return $fieldarray;
        } // if

        $this->fieldarray = $fieldarray;

        if ($this->dbname != 'workflow') {
            if (is_string($where)) {
                // find out if this task/context is a workitem within a workflow instance
                $this->_examineWorkflowInstance($where);
            } // if
        } // if

        return $fieldarray;

    } // getInitialDataMultiple

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
        $messages = (array)$this->messages;

        $this->messages = array();

        return $messages;

    } // getLookupData

    // ****************************************************************************
    function getNodeData ($expanded, $where=null)
    // retrieve requested tree structure from the database.
    // $expanded may be a list of nodes which are to be expanded, or the word
    // 'ALL' to sigify that all possible nodes should be expanded.
    // $where identifies the start point of a tree structure
    {
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
        $pattern = '/( asc| desc)$/i';
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
        if (empty($fieldarray)) {
            $fieldarray = $this->fieldarray;
        } // if

        reset($fieldarray);   // fix for version 4.4.1
        if (!is_array($fieldarray[key($fieldarray)])) {
            // array is one level deep - convert to 2 levels
            $fieldarray2[0] = $fieldarray;
            $fieldarray     = $fieldarray2;
        } // if

        $pkeynames = $this->getPkeyNames();

        $pkeyarray = array();
        $rowcount  = 0;

        // step through each row
        foreach ($fieldarray as $row) {
            // note that $rowcount starts at 1, not 0
            $rowcount++;
            foreach ($pkeynames as $fieldname) {
                // add 'name=value' to array
                $pkeyarray[$rowcount][$fieldname] = $row[$fieldname];
            } // foreach
        } // foreach

        return $pkeyarray;

    } // getPkeyArray

    // ****************************************************************************
    function getPkeyNames ()
    // return the list of primary key fields in this table.
    {
        if (!empty($this->primary_key)) {
            $array = $this->primary_key;
        } else {
            // get names from contents of $this->fieldspec
            $array = array();
            foreach ($this->fieldspec as $field => $spec) {
                // look for keyword 'pkey' in field specifications
                if (isset($spec['pkey'])) {
                    $array[] = $field;
                } // if
            } // foreach
        } // if

        return $array;

    } // getPkeyNames

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
    function getSearch ()
    // return current selection criteria.
    {
        if (empty($this->sql_where)) {
            $search = $this->sql_search;
        } elseif (empty($this->sql_search)) {
            $search = $this->sql_where;
        } else {
            $search = mergeWhere($this->sql_where, $this->sql_search);
        } // if

        return $search;

    } // getSearch

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
    function initialise ($where1, $where2=null)
    // perform any initialisation for the current task.
    {
        $this->pageno = null;

        // change current table configuration (optional)
        $fieldarray = where2array($where1);
        $fieldarray = $this->_cm_changeConfig($where1, $fieldarray);

        if (!empty($where1)) {
        	// remove any fields which do not exist in current table to avoid an SQL error
            $where1 = whereFilter($where1, $this->fieldspec, $this->tablename);
            $fieldarray = where2array($where1);
        } else {
            $fieldarray = array();
        } // if

        if (!empty($where2)) {
        	// remove entries from $where2 that already exist in $where1
            $array2 = where2array($where2);
            foreach ($array2 as $key => $value) {
            	if (array_key_exists($key, $fieldarray)) {
            		unset($array2[$key]);
            	} else {
                	// look for any unqualified field names
                	$namearray = explode('.', $key);
                	if (!isset($namearray[1])) {
                		// does it exist in current table?
                		if (array_key_exists($key, $this->fieldspec)) {
                			// it does exist, so qualify it
                			$array2["$this->tablename.$key"] = $value;
                			unset($array2[$key]);
                		} else {
                		    // it does not exist, so delete it
                		    unset($array2[$key]);
                		} // if
                	} // if
            	} // if
            } // foreach
            $where2 = array2where($array2);
            $this->sql_search = mergeWhere($this->sql_search, $where2);
        } // if

        if ($GLOBALS['mode'] == 'search') {
            // rebuild array to incude '=' and 'LIKE' operators
            $fieldarray = where2array($where1, null, false);
            // do not allow any $where criteria to be changed
            foreach ($fieldarray as $fieldname => $fieldvalue) {
                if (!empty($fieldvalue)) {
                    if (eregi('^LIKE ', ltrim($fieldvalue))) {
                        // ignore values starting with 'LIKE ' as they came from previous search
                    } else {
                    	$this->fieldspec[$fieldname]['noedit'] = 'y';
                        if (eregi('^(null)$', $fieldvalue)) {
                            // replace 'null' (the string) with NULL (the value)
                            $firstrow[$fieldname] = null;
                        } // if
                    } // if
                } // if
            } // foreach

            foreach ($this->fieldspec as $fieldname => $fieldspec) {
                // do not display any fields marked with 'nosearch'
                if (isset($fieldspec['nosearch'])) {
                    $this->fieldspec[$fieldname]['nodisplay'] = 'y';
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
                $fieldarray = array_merge($previous, $fieldarray);
                // convert back into string
                $where1 = array2where($fieldarray);
            } // if
        } // if

        // call customisable methods in the subclass.
        $where1 = $this->_cm_initialise($where1);

        $this->javascript = $this->_cm_setJavaScript($this->javascript);

        return $where1;

    } // initialise

    // ****************************************************************************
    function initialiseFileDownload ($where)
    // perform any initialisation for the file download operation.
    {
        $fieldarray = $this->getData_raw($where);

        if ($this->numrows < 1) {
            $this->errors[] = getLanguageText('sys0085'); // 'Nothing retrieved from the database.'
            return false;
        } // if

        // change from indexed to associative for first row
        $fieldarray = $fieldarray[0];

        $this->download_filename = 'download_filename';
        $this->download_mode     = '';  // 'inline' will disabe option to save

        // call customisable method in the subclass.
        $fieldarray = $this->_cm_initialiseFileDownload($fieldarray);

        if (!file_exists($this->download_filename) ) {
            // 'file does not exist'
            $this->errors[] = getLanguageText('sys0057', $this->download_filename);
        } // if

        return $fieldarray;

    } // initialiseFileDownload

    // ****************************************************************************
    function initialiseFilePicker ()
    // perform any initialisation for the filepicker operation.
    {
        $this->picker_subdir      = 'picker';
        $this->picker_filetypes   = array();

        // call customisable method in the subclass.
        $this->_cm_initialiseFilePicker();

        if (!is_dir($this->picker_subdir) ) {
            // 'source directory does not exist'
            $this->errors[] = getLanguageText('sys0059', $this->picker_subdir);
        } // if

        // turn array of file types into a string
        $string = '';
        foreach ($this->picker_filetypes as $filetype) {
         	if (empty($string)) {
         		$string = "(\." .$filetype;
         	} else {
         	    $string .= "|\." .$filetype;
         	} // if
        } // foreach
        $string .= ')$';

        $this->picker_filetypes = $string;

        return;

    } // initialiseFilePicker

    // ****************************************************************************
    function initialiseFileUpload ($where)
    // perform any initialisation for the file upload operation.
    {
        $fieldarray = where2array($where);

        $this->upload_subdir      = 'uploadedfiles';
        $this->upload_filetypes   = array('image/gif');
        $this->upload_maxfilesize = 100;

        // call customisable method in the subclass.
        $fieldarray = $this->_cm_initialiseFileUpload($fieldarray);

        if (!is_dir($this->upload_subdir) ) {
            // 'destination directory does not exist'
            $this->errors[] = getLanguageText('sys0123', $this->upload_subdir);
        } // if

        $this->where = array2where($fieldarray);

        return;

    } // initialiseFileUpload

    // ****************************************************************************
    function insertMultiple ($fieldarray)
    // insert multiple records using data in $fieldarray.
    {
        $errors = array();
        $count  = 0;

        reset($fieldarray);   // fix for version 4.4.1
        if (is_string(key($fieldarray))) {
            // array is NOT indexed by row, so adjust it
            $array[] = $fieldarray;
            $fieldarray = $array;
        } // if

        // turn off feature in getInitialData() method
        $this->ignore_empty_fields = true;

        // perform any additional custom pre-processing
        $fieldarray = $this->_cm_pre_insertMultiple($fieldarray);

        if (!$this->errors) {
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
            // 'X records were inserted into tablename'
            $this->messages[] = getLanguageText('sys0005', $count, strtoupper($this->tablename));

            // perform any additional custom post-processing
            $fieldarray = $this->_cm_post_insertMultiple($fieldarray);
        } // if

        $this->ignore_empty_fields = false;

        return $fieldarray;

    } // insertMultiple

    // ****************************************************************************
    function insertRecord ($fieldarray)
    // insert a record using contents of $fieldarray.
    {
        $this->errors = array();   // initialise

        if (!empty($fieldarray)) {
            reset($fieldarray);   // fix for version 4.4.1
            if (!is_string(key($fieldarray))) {
                // input is indexed by row, so extract data for 1st row only
                $array = $fieldarray[key($fieldarray)];
                $fieldarray = $array;
            } // if
        } // if

        // shift all field names to lower case
        $fieldarray = array_change_key_case($fieldarray, CASE_LOWER);

        // do not allow auto-insert/autoupdate fields to be pasted into an insert screen
        foreach ($this->fieldspec as $field => $spec) {
            if (array_key_exists('autoinsert', $spec) or array_key_exists('autoupdate', $spec)) {
                unset($fieldarray[$field]);
            } // if
        } // foreach

        // redo any custom initialisation
        $fieldarray = $this->_cm_getInitialData($fieldarray);

        // perform any custom pre-insert processing
        $fieldarray = $this->_cm_pre_insertRecord($fieldarray);

        if (empty($this->errors)) {
            // perform standard declarative checks on input array
            // NOTE: this produces another array with data formatted for the database
            $insertarray = $this->_validateInsert($fieldarray);
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

        if (empty($this->errors)) {
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

        // store updated $fieldarray within this object
        $this->fieldarray = $fieldarray;

        if (empty($this->errors)) {
            $this->numrows = $this->numrows +1;
        } // if

        return $fieldarray;

    } // insertRecord

    // ****************************************************************************
    function outputCSV ($resource)
    // read database resource and output all records to a CSV file.
    {
        $output = '';

        // allow output to be customised
        $output = $this->_cm_pre_output($output);

        // fetch database rows one at a time
        while ($fieldarray = $this->fetchRow($resource)) {
            if (empty($output)) {
            	// first row, so output field names as labels
                foreach ($fieldarray as $fieldname => $fieldvalue) {
                    $fieldname = getLanguageText($fieldname);
                    $output .= '"' .$fieldname .'",';
                } // foreach
                // strip last ',' and append <newline>
                $output = substr($output, 0, strlen($output) - 1);
                $output .= "\r\n";
            } // if
            // perform any data formatting
            $fieldarray = $this->formatData($fieldarray);
            // output each field as data
            foreach ($fieldarray as $fieldname => $fieldvalue) {
                $output .= '"' .addslashes($fieldvalue) .'",';
            } // foreach
            // strip last ',' and append <newline>
            $output = substr($output, 0, strlen($output) - 1);
            $output .= "\r\n";
        } // while

        // perform any post processing
        $output = $this->_cm_post_output($output);

        return $output;

    } // outputCSV

    // ****************************************************************************
    function outputPDF_DetailView ($resource, $structure)
    // read database resource and output all records to a PDF file in DETAIL view
    // using the layout defined in the $structure
    {
        // create PDF document
        require 'std.pdf.class.inc';
        $pdf = new PDF($structure);

        // allow filename to be customised
        $pdf->filename = $this->_cm_pre_output($pdf->filename);
        if (eregi('(F|D)', $structure['pdf']['destination'])) {
        	if (empty($pdf->filename)) {
        	    // set default file name for PDF output
        		$pdf->filename = basename($_SERVER['PHP_SELF'], '.php') .'.pdf';
        	} // if
        } // if

        // format data using LIST view
        $pdf->detailView($this, $resource);

        // output the completed document
        $string = $pdf->Output($pdf->filename, $pdf->destination);

        // perform any post processing
        $string = $this->_cm_post_output($string);

        return strtoupper($pdf->destination);

    } // outputPDF_DetailView

    // ****************************************************************************
    function outputPDF_ListView ($resource, $structure)
    // read database resource and output all records to a PDF file in LIST view
    // using the layout defined in the $structure
    {
        // create PDF document
        require 'std.pdf_list.class.inc';
        $pdf = new PDF_list($structure);

        // allow filename to be customised
        $pdf->filename = $this->_cm_pre_output($pdf->filename);
        if (eregi('(F|D)', $structure['pdf']['destination'])) {
        	if (empty($pdf->filename)) {
        	    // set default file name for PDF output
        		$pdf->filename = basename($_SERVER['PHP_SELF'], '.php') .'.pdf';
        	} // if
        } // if

        // format data using LIST view
        $pdf->listView($this, $resource);

        // output the completed document
        $string = $pdf->Output($pdf->filename, $pdf->destination);

        // perform any post processing
        $string = $this->_cm_post_output($string);

        return strtoupper($pdf->destination);

    } // outputPDF_ListView

    // ****************************************************************************
    function popupCall ($popupname, $where, &$script_vars, $fieldarray, &$settings)
    // processing before a popup form is called.
    // NOTE: $script_vars is passed BY REFERENCE as it may be altered.
    {
        // clear any previous selection
        $script_vars['selection'] = NULL;

        // the default is to select only one entry
        $settings_array['select_one'] = true;

        // allow $where and $settings to be altered
        $where = $this->_cm_popupCall(strtolower($popupname), $where, $fieldarray, $settings_array);

        $settings = '';
        // convert $settings array into a string
        foreach ($settings_array as $key => $value) {
            if (is_bool($value)) {
            	if ($value === true) {
            	    $value = 'TRUE';
            	} else {
                	$value = 'FALSE';
                } // if
            } // if
            if (empty($string_out)) {
        	    $settings = "$key=$value";
            } else {
                $settings .= "&$key=$value";
            } // if
        } // foreach

        return $where;

    } // popupCall

    // ****************************************************************************
    function popupReturn ($fieldarray, $return_from, $selection, $popup_offset=null)
    // process a selection returned from a popup screen.
    // $fieldarray contains the record data when the popup button was pressed.
    // $return_from identifies which popup screen was called.
    // $selection contains an array of item(s) selected in that popup screen.
    {
        $this->errors = array();

        $return_from = strtolower($return_from);

        reset($fieldarray);   // fix for version 4.4.1
        if (!empty($fieldarray) and !is_string(key($fieldarray))) {
            if (is_null($popup_offset)) {
                // extract first row
            	$single_row = $fieldarray[key($fieldarray)];
            	$popup_offset = key($fieldarray)+1;
            } else {
                // extract specified row
                $single_row = $fieldarray[$popup_offset-1];
            } // if
        } else {
            // not inexed by row, so use entire array
            $single_row = $fieldarray;
        } // if

        if (substr_count($selection, '=') == 0) {
            $found = false;
            // selection is not in format 'key=value', so it must be from a filepicker
            foreach ($this->fieldspec as $field => $spec) {
                if (isset($spec['task_id'])) {
                    if ($spec['task_id'] == $return_from) {
                        $found = true;
                        // now empty the description field obtained from the foreign table
                        $single_row[$field] = $selection;
                        break;
                    } // if
                } // if
            } // foreach
            if ($found) {
            	// call custom method for specific processing
                $single_row = $this->_cm_popupReturn($single_row, $return_from, $selection);
                // store updated $fieldarray within this object
                $this->fieldarray = $single_row;
            } // if
            return $single_row;
        } // if

        // convert selection string into an associative array
        $select_array = where2array($selection);

        // find entry which uses this popup form
        $found = false;
        foreach ($this->fieldspec as $field => $spec) {
            if (isset($spec['task_id'])) {
                if ($spec['task_id'] == $return_from) {
                    $found = true;
                    // merge $selection with $fieldarray
                    $single_row = array_merge($single_row, $select_array);
                    // now remove the description field obtained from the foreign table
                    if (isset($spec['foreign_field'])) {
                        unset($single_row[$spec['foreign_field']]);
                    } // if
                    break;
                } // if
            } // if
        } // foreach

        if ($found) {
            // call custom method for specific processing
            $single_row = $this->_cm_popupReturn($single_row, $return_from, $selection);

            if ($GLOBALS['mode'] == 'insert') {
                // redo any custom initialisation
                $single_row = $this->_cm_getInitialData($single_row);
            } // if

            // retrieve data from foreign (parent) tables
            $single_row = $this->getForeignData($single_row);
        } // if

        if (!empty($fieldarray) and !is_string(key($fieldarray))) {
            // insert sigle row into array
            $fieldarray[$popup_offset-1] = $single_row;
        } else {
            // not inexed by row, so replace entire array
            $fieldarray = $single_row;
        } // if

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
    function reset ($where=null)
    // reset all screen settings before starting afresh.
    {
        $this->setSqlSearch(null);
        $this->setOrderBy(null);
        $this->setOrderBySeq(null);

        //$this->setPageNo(null);
        $where = $this->initialise($where);

        return $where;

    } // reset

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
        //$array['C'] = 'Current';
        //$array['H'] = 'Historic';
        //$array['F'] = 'Future';
        //$array['A'] = 'All';
        $array = getLanguageArray('curr_or_hist');
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
        $this->errors = array();
        $array = array();

        // MNU_ROLE_TASKFIELD contains a list of fields for the current task
        // which may have the default ACCESS_TYPE altered for the current role.

        // first we must obtain the user's current role setting
        $dbrole =& singleton::getInstance('mnu_role');
        $dbrole_data = $dbrole->getRole();
        if ($dbrole->errors) {
        	$this->errors = $dbrole->errors;
        	return FALSE;
        } // if

        $role_id       = $dbrole_data['role_id'];
        $global_access = $dbrole_data['global_access'];

        // If the security class has GLOBAL_ACCESS = 'y' there are no restrictions.
        if ($global_access) return $array;

        $dbobject =& singleton::getInstance('mnu_role_taskfield');

        $dbobject->sql_select = 'role_id,task_id,field_id,access_type';
        $dbobject->sql_from   = 'mnu_role_taskfield ';
        $dbobject->sql_where  = "mnu_role_taskfield.role_id='$role_id' ";

        $dbobject->sql_orderby = '';
        $PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'
        $where = "task_id='" .$_SESSION[$PHP_SELF]['task_id'] ."'";

        $accessarray = $dbobject->getData_raw($where);
        $this->errors = $dbobject->getErrors();

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
            reset($fieldarray);   // fix for version 4.4.1
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

        if ($this->numrows == 0) {
            $this->pageno   = 0;
        	$this->lastpage = 0;
        } // if

        return;

    } // setFieldArray

    // ****************************************************************************
    function setInstruction ($instruction)
    // load an optional instruction from the previous script.
    {
        $this->instruction = $instruction;

        // process any instruction to expand a tree node
        if (array_key_exists('expand', $instruction)) {
            $this->expanded[$instruction['expand']] = true;
            unset($instruction['expand']);
        } // if

    } // setInstruction

    // ****************************************************************************
    function setLookupData ($input=null)
    // fetch any lookup data and load into member variable.
    {
        // $input may be an array or a string
        if (is_array($input)) {
            reset($input);   // fix for version 4.4.1
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
        if (empty($sql_orderby)) {
            // nothing specifed, so use the default instead
            $sql_orderby = $this->default_orderby;
        } else {
            $sql_orderby = trim(strtolower($sql_orderby));
        } // if

        $this->sql_orderby = $sql_orderby;

        if (empty($this->sql_orderby)) {
            $this->sql_orderby_seq = NULL;
        } else {
            if (!empty($sql_orderby_seq)) {
                $this->sql_orderby_seq = $sql_orderby_seq;
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
        // convert $where (string) into an array of 'name=value' pairs
        $wherearray = where2array($where);

        // call custom method to construct $this->scrollarray
        $array = $this->_cm_setScrollArray($where, $wherearray);

        // shift entries so that they start at position 1 not 0
        array_unshift($array, 'dummy');
        unset($array[0]);

        // save this array for use during this object's life
        $this->scrollarray = $array;

        if ($this->pageno < 1) {
            $this->pageno = 1;
        } // if

        // replace $where with details from 1st entry in scrollarray
        if (is_array($this->scrollarray[$this->pageno])) {
            $where = array2where($this->scrollarray[$this->pageno]);
        } else {
            $where = $this->scrollarray[$this->pageno];
        } // if

        // set initial values to be used by scrolling logic
        $this->scrollindex = $this->pageno;
        $this->numrows     = count($this->scrollarray);
        $this->lastpage    = count($this->scrollarray);

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
        //$this->sql_orderby     = NULL;
        //$this->sql_orderby_seq = NULL;

    } // setSqlSearch

    // ****************************************************************************
//    function setSelectArray ($selection)
//    // set optional selection criteria to be used in sql select
//    {
//        if (is_array($selection)) {
//            // use only 1st element of this array
//            $this->selectarray = $selection[key($selection)];
//        } else {
//            // convert string to an associative array
//            $this->selectarray = where2array($selection);
//        } // if
//
//    } // setSelectArray

    // ****************************************************************************
    function sqlSelectInit ()
    // initialise all variables used in the sql SELECT statement
    {
        $this->sql_select      = null;
        $this->sql_from        = null;
        $this->sql_where       = null;
        $this->sql_groupby     = null;
        $this->sql_orderby     = null;
        $this->sql_orderby_seq = null;
        $this->sql_having      = null;

    } // sqlSelectInit

    // ****************************************************************************
    function startTransaction ()
    // start a new transaction, to be terminated by either COMMIT or ROLLBACK.
    {
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
                        // split into $dbname and $tablename
                        list($dbname, $tablename) = explode('.', $tablename);
                    } else {
                        $dbname = $this->dbname;
                    } // if
                    if (array_key_exists($dbname, $std_lock['READ'])) {
                        if (in_array($tablename, $std_lock['READ'][$dbname])) {
                            if ($mode == 'WRITE') {
                                // remove any entry for the same table in the READ array
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
                        // split into $dbname and $tablename
                        list($dbname, $tablename) = explode('.', $tablename);
                        $new_array[$mode][] = '"' .$dbprefix .$dbname .'".' .$tablename;
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
                            $new_array[$mode][] = '"' .$dbprefix .$std_dbname .'".' .$std_tablename;
                        } // if
                    } // foreach
                } // foreach
            } // foreach

        } // if

        $DML->transaction_level = $this->transaction_level;
        $DML->table_locks       = $new_array;
        $DML->row_locks         = $this->row_locks;         // EX=Exclusive, SH=shared
        $DML->row_locks_supp    = $this->row_locks_supp;    // DBMS-specific

        $result = $DML->startTransaction($this->dbname);

        $GLOBALS['transaction_has_started'] = TRUE;

        return $result;

    } // startTransaction

    // ****************************************************************************
    function unFormatData ($fieldarray)
    // remove any formatting before data is given to the database.
    // (such as changing dates from 'dd Mmm CCYY' to 'CCYY-MM-DD')
    {
        $dateobj =& singleton::getInstance('date_class');

        foreach ($fieldarray as $fieldname => $fieldvalue) {
            // only deal with fields defined in $fieldspec
            if (isset($this->fieldspec[$fieldname])) {
                // get specifications for current field
                $fieldspec = $this->fieldspec[$fieldname];
                if (!isset($fieldspec['type'])) {
                    $fieldspec['type'] = 'string';  // set default type
                } // if

                $operators = "/^(<>|<=|<|>=|>|!=|=|LIKE |IS NOT |IS |IN |BETWEEN )/i";
                // does $fieldvalue start with a valid operator?
                if (!preg_match($operators, ltrim($fieldvalue), $regs)) {
                    // no, so value can be (un)formatted
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

        $default_orderby = $this->default_orderby; // save

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

        $this->default_orderby = $default_orderby; // restore

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
        $this->errors  = array();
        $this->numrows = 0;
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
            // overwrite proper variables
            $this->errors  = $errors;
            $this->numrows = $count;
        } // if

        // '$count records were updated in $tablename'
        $this->messages[] = getLanguageText('sys0006', $count, strtoupper($this->tablename));

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
        if (empty($fieldarray)) return $fieldarray;

        reset($fieldarray);
        if (!is_string(key($fieldarray))) {
            // input is indexed by row, so extract data for 1st row only
            $fieldarray = $fieldarray[key($fieldarray)];
        } // if

        // shift all field names to lower case
        $fieldarray = array_change_key_case($fieldarray, CASE_LOWER);

        $this->errors = array();

        // perform any custom pre-update processing
        $fieldarray = $this->_cm_pre_updateRecord($fieldarray);

        if (empty($this->errors)) {
            // perform standard declarative checks on input data
            $updatearray = $this->_validateUpdate($fieldarray);
        } // if

        if (empty($this->errors)) {
            // build 'where' string using values for primary key
            $pkey_names = $this->getPkeyNames();
            if (array_key_exists('rdcversion', $this->fieldspec) AND array_key_exists('rdcversion', $fieldarray)) {
                // add this field to the WHERE clause for this lookup
            	$pkey_names[] = 'rdcversion';
            } // if
            $where = array2where($updatearray, $pkey_names);
            // obtain copy of original record from database
            $originaldata = $this->_dml_ReadBeforeUpdate($where);
            if ($this->numrows <> 1) {
                // 'Could not locate original $tablename record for updating ($where)'
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

        if (empty($this->errors)) {
            // everything OK so far, so update the database

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
    function validateDelete ($fieldarray)
    // verify that the specified record can be deleted.
    {
        $this->errors = array();

        if ($this->skip_validation) {
            // skip any validation
            return $fieldarray;
        } // if

        if (is_string($fieldarray)) {
            $fieldarray = where2array($fieldarray);
        } else{
            reset($fieldarray);   // fix for version 4.4.1
            if (!is_string(key($fieldarray))) {
                // index by row, so use row zero only
                $fieldarray = $fieldarray[key($fieldarray)];
            } // if
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
                    $where = $this->_dml_adjustWhere($where);  // replace escape character if different
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
                    $where = $this->_dml_adjustWhere($where);  // replace escape character if different
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

        // delete selected records.
        $count = $this->_dml_deleteSelection($selection);

        // $count rows were deleted
        return getLanguageText('sys0004', $count, strtoupper($this->tablename));

    } // _cm_deleteSelection

    // ****************************************************************************
    function _cm_fileUpload ($input_name, $temp_file, $wherearray)
    // Specify file name to be used for the upload.
    // $input_name  = file name supplied by client
    // $temp_file   = copy of file in temp directory
    // $wherearray  = contents of original $where string
    // $output_name = file name to be used on server
    {
        // default name for destination file is same as input name
        $output_name = $input_name;

        return $output_name;

    } // _cm_fileUpload

    // ****************************************************************************
    function _cm_formatData ($fieldarray, &$css_array)
    // perform custom formatting before values are shown to the user.
    // Note: $css_array is passed BY REFERENCE as it may be modified.
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
    // Perform custom processing prior to insertRecord().
    // $fieldarray contains data from the initial $where clause.
    {

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getInitialDataMultiple ($fieldarray)
    // Perform custom processing prior to insertMultiple.
    // $fieldarray contains data from the initial $where clause.
    {

        return $fieldarray;

    } // _cm_getInitialDataMultiple

    // ****************************************************************************
    function _cm_getNodeData ($expanded, $where, $wherearray)
    // retrieve requested node data from the database.
    // $expanded may be a list of nodes to be expanded, or 'ALL' nodes.
    // $where may contain specific selection criteria as a string.
    // $wherearray is $where but converted into an array.
    {
        $this->sql_select  = 'tree_node.node_id, tree_node.node_desc, tree_level.tree_level_seq, COUNT(child.node_id) AS child_count';
        $this->sql_from    = 'tree_level, tree_node '
                           . 'LEFT JOIN tree_node AS child ON (tree_node.node_id=child.node_id_snr)';
        $this->sql_where   = 'tree_level.tree_type_id=tree_node.tree_type_id AND tree_level.tree_level_id=tree_node.tree_level_id';
        $this->sql_groupby = 'tree_node.node_id, tree_node.node_desc, tree_node.tree_level_id, tree_level.tree_level_seq';
        $this->sql_having  = '';
        $this->sql_orderby = 'tree_node.tree_level_id, tree_node.node_id';

        if (array_key_exists('tree_type_id', $wherearray)) {
            // look for root nodes within this tree_type
            $wherearray['tree_level_seq'] = 1;
            $where = array2where($wherearray);
        } // if

        $data_raw = $this->getData($where);

        foreach ($data_raw as $row => $rowdata) {
            // append data for current node to output array
            $fieldarray[] = $rowdata;
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
    function _cm_getValRep ($item=null, $where=null)
    // get Value/Representation list as an associative array.
    {
        $array = array();

//        if ($item == 'item1_id') {
//            // get data from the database
//            $this->sql_select     = 'item1_id, item1_desc';
//            $this->sql_orderby    = 'item1_desc';
//            $this->sql_ordery_seq = 'asc';
//            $data = $this->getData(null);
//
//            // convert each row into 'id=desc' in the output array
//            foreach ($data as $row => $rowdata) {
//                $rowvalues = array_values($rowdata);
//                $array[$rowvalues[0]] = $rowvalues[1];
//            } // foreach
//
//            return $array;
//
//        } // if

//        if ($item == 'item2') {
//            $array = getLanguageArray('item2');
//            return $array;
//        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_initialise ($where)
    // perform any initialisation for the current task.
    {
        // customisable code goes here
        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_initialiseFileDownload ($fieldarray)
    // perform any initialisation for the file download operation.
    {
        //$this->download_filename = $fieldarray['download_filename'];
        //$this->download_mode     = 'inline';  // disable option to save

        return;

    } // _cm_initialiseFileDownload

    // ****************************************************************************
    function _cm_initialiseFilePicker ()
    // perform any initialisation before displaying the File Picker screen.
    {
        // identify the subdirectory which contains the files
        $this->picker_subdir      = 'filepickersubdirectory';

        // identify the file types that may be picked
        $this->picker_filetypes   = array('txt', 'bmp', 'doc');

        return;

    } // _cm_initialiseFilePicker

    // ****************************************************************************
    function _cm_initialiseFileUpload ($fieldarray)
    // perform any initialisation before displaying the File Upload screen.
    {
        $this->upload_subdir      = 'uploadedfiles';
        $this->upload_filetypes   = array('image/x-png', 'image/gif');
        $this->upload_maxfilesize = 100;

        return;

    } // _cm_initialiseFileUpload

    // ****************************************************************************
    function _cm_ListView_total ()
    // pass back any data to be printed on last line of PDF report (list view).
    {
        $array = array();

        return $array;

    } // _cm_ListView_total

    // ****************************************************************************
    function _cm_output_multi ($name, $fieldarray)
    // get extra data to pass to PDF class.
    {
        $outarray = array();

        switch ($name) {
        	case 'multi1':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi2':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi3':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi4':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi5':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi6':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi7':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi8':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	case 'multi9':
                // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;

        	default:
        	    // return a non-empty array to print an empty line
                $outarray[] = array('dummy' => '');
        		break;
        } // switch

        if ($outarray) {
        	return $outarray;
        } else {
            return false;
        } // if

    } // _cm_output_multi

    // ****************************************************************************
    function _cm_popupCall ($popupname, $where, $fieldarray, &$settings)
    // if a popup button has been pressed the contents of $where may need to
    // be altered before the popup screen is called.
    // NOTE: $settings is passed BY REFERENCE as it may be altered as well.
    {
        // clear out the contents of $where
        $where = '';

        // allow only one entry to be selected (the default)
        //$settings['select_one'] = true;

        // allow more than one entry to be selected
        //$settings['select_one'] = false;

        //if ($popupname == '???_popup') {
        //   // replace $where for this popup
        //   $where = "???_id='ORG'";
        //} // if

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
    function _cm_post_getData ($rows, &$where)
    // perform custom processing after database record(s) are retrieved.
    // NOTE: $where is passed BY REFERENCE so that it may be modified.
    {
        // customisable code goes here

        return $rows;

    } // _cm_post_getData

    // ****************************************************************************
    function _cm_post_insertMultiple ($rows)
    // perform custom processing after multiple database records are inserted.
    {

        return $rows;

    } // _cm_post_insertMultiple

    // ****************************************************************************
    function _cm_post_insertRecord ($rowdata)
    // perform custom processing after database record has been inserted.
    {

        return $rowdata;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_post_output ($string)
    // perform any processing required after the output operation
    {
        // custom code goes here

        return $string;

    } // _cm_post_output

    // ****************************************************************************
    function _cm_post_updateLinkdata ($rows, $postarray)
    // perform custom processing after multiple database records have been updated.
    {

        return $rows;

    } // _cm_post_updateLinkData

    // ****************************************************************************
    function _cm_post_updateMultiple ($rows)
    // perform custom processing after multiple database records have been updated.
    {
        return $rows;

    } // _cm_post_updateMultiple

    // ****************************************************************************
    function _cm_post_updateRecord ($rowdata, $old_data)
    // perform custom processing after database record is updated.
    {

        return $rowdata;

    } // _cm_post_updateRecord

    // ****************************************************************************
    function _cm_pre_deleteRecord ($rowdata)
    // perform custom processing before database record is deleted.
    // if anything is placed in $this->errors the deletion will be terminated.
    {

        return $rowdata;

    } // _cm_pre_deleteRecord

    // ****************************************************************************
    function _cm_pre_eraseRecord ($rowdata)
    // perform custom processing before database record is erased.
    // if anything is placed in $this->errors the erasure will be terminated.
    {

        return $rowdata;

    } // _cm_pre_eraseRecord

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_insertMultiple ($rows)
    // perform custom processing before multiple database records are inserted.
    // if anything is placed in $this->errors the insert will be terminated.
    {

        return $rows;

    } // _cm_pre_insertMultiple

    // ****************************************************************************
    function _cm_pre_insertRecord ($rowdata)
    // perform custom processing before database record is inserted.
    // if anything is placed in $this->errors the insert will be terminated.
    {

        return $rowdata;

    } // _cm_pre_insertRecord

    // ****************************************************************************
    function _cm_pre_output ($string)
    // perform any processing required before the output operation
    {
        // custom code goes here

        return $string;

    } // _cm_pre_output

    // ****************************************************************************
    function _cm_pre_updateLinkdata ($rows, &$postarray)
    // $rows is an array of field data (multiple rows).
    // $postarray is an array of entries which have been selected.
    // NOTE: $postarray is passed BY REFERENCE so that it may be modified.
    // NOTE: $rows starts at 0, $select starts at 1.
    // if anything is placed in $this->errors the update will be terminated.
    {

        return $rows;

    } // _cm_pre_updateLinkData

    // ****************************************************************************
    function _cm_pre_updateMultiple ($rows)
    // perform custom processing before multiple database records are updated.
    {
        return $rows;

    } // _cm_pre_updateMultiple

    // ****************************************************************************
    function _cm_pre_updateRecord ($rowdata)
    // perform custom processing before database record is updated.
    // errors are added to $this->errors.
    {
        //$this->row_locks = 'SH';    // shared
        //$this->row_locks = 'EX';    // exclusive
        //$this->row_locks_supp = '?' // DBMS-specific

        return $rowdata;

    } // _cm_pre_updateRecord

    // ****************************************************************************
    function _cm_setJavaScript ($javascript)
    // insert any javascript to be included in the <HEAD> or <BODY> elements.
    {
        // customisable code goes here
        //$javascript['head'][]['file'] = '...';
        //$javascript['head'][]['code'] = '...';

        //$javascript['body']['onload'] = '...';
        //$javascript['body']['onunload'] = '...';

        return $javascript;

    } // _cm_setJavaScript

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
        // this is the default code, which may be replaced if necessary
        $count = $this->_dml_updateSelection($selection, $replace);

        // '$count records were updated in $tablename'
        return getLanguageText('sys0006', $count, strtoupper($this->tablename));

    } // _cm_updateSelection

    // ****************************************************************************
    function _cm_validateDelete ($rowdata)
    // verify that the selected record can be deleted.
    // if anything is placed in $this->errors the delete will be terminated.
    {

        return;

    } // _cm_validateDelete

    // ****************************************************************************
    function _cm_validateInsert ($rowdata)
    // perform custom validation before an insert.
    // if anything is placed in $this->errors the insert will be terminated.
    {

        return $rowdata;

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
        $DDL =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $array = $DDL->ddl_getColumnSpecs();

        return $array;

    } // _ddl_getColumnSpecs

    // ****************************************************************************
    function _ddl_showColumns($dbname, $tablename)
    // obtain a list of column names for the selected database table.
    {
        $DDL =& $this->_getDBMSengine($this->dbms_engine,$this->dbname);

        $array = $DDL->ddl_showColumns($dbname, $tablename);

        return $array;

    } // _ddl_showColumns

    // ****************************************************************************
    function _ddl_showCreateTable ($dbname, $tablename)
    // obtain a list of column names for the selected database table.
    {
        $DDL =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $array = $DDL->ddl_showCreateTable($dbname, $tablename);

        return $array;

    } // _ddl_showCreateTable

    // ****************************************************************************
    function _ddl_showDatabases ()
    // obtain a list of existing database names.
    {
        $DDL =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $array = $DDL->ddl_showDatabases();

        return $array;

    } // _ddl_showDatabases

    // ****************************************************************************
    function _ddl_showTables ($dbname)
    // obtain a list of table names for the selected database.
    {
        $DDL =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $array = $DDL->ddl_showTables($dbname);

        return $array;

    } // _ddl_showTables

    // ****************************************************************************
    function _ddl_showTableKeys ($dbname, $tablename)
    // obtain a list of existing database names.
    {
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
    function _dml_adjustWhere ($string_in)
    // the DBMS may require different escape characters, so adjust as necessary.
    {
        $DML =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        if (method_exists($DML, 'adjustWhere')) {
        	$string_out = $DML->adjustWhere($string_in);
        } else {
            $string_out = $string_in;
        } // if

        return $string_out;

    } // _dml_adjustWhere

    // ****************************************************************************
    function _dml_deleteSelection ($selection)
    // delete a selection of records in a single operation.
    {
        $DML =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $DML->fieldspec     = $this->fieldspec;
        $DML->audit_logging = $this->audit_logging;

        if (!$this->audit_logging) {
            // no audit logging, so delete everything in one operation
            $count = $DML->deleteSelection($this->dbname, $this->tablename, $selection);
            $this->errors = array_merge($DML->getErrors(), $this->errors);
        } else {
            $this->sqlSelectInit();
            // audit logging is ON, so fetch everything and delete one row at a time
            $resource = $this->getData_batch($selection);
            $count    = $this->numrows;
            $errors   = array();
            while ($row = $this->fetchRow($resource)) {
            	$this->_dml_deleteRecord($row);
                $errors = array_merge($this->getErrors(), $errors);
            } // while
            $this->errors = $errors;
        } // if

        $this->numrows = $count;

        return $count;

    } // _dml_deleteSelection

    // ****************************************************************************
    function _dml_getCount ($where)
    // Get count of recors which match criteria in $where.
    {
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
        $DML =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $array = $DML->getEnum($this->dbname, $this->tablename, $item);

        $this->errors = array_merge($DML->getErrors(), $this->errors);

        return $array;

    } // _dml_getEnum

    // ****************************************************************************
    function _dml_insertRecord ($fieldarray)
    // insert a record using the contents of $fieldarray.
    {
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
        $DML =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $DML->fieldspec        = $this->fieldspec;
        $DML->pageno           = 1;
        $DML->rows_per_page    = 0;
        $DML->sql_from         = NULL;
        $DML->sql_groupby      = NULL;
        $DML->sql_having       = NULL;
        $DML->sql_orderby      = NULL;
        $DML->sql_orderby_seq  = NULL;
        $DML->sql_select       = NULL;
        $DML->setRowLocks('EX');   // lock this row (exclusive)

        $array = $DML->getData($this->dbname, $this->tablename, $where);

        $this->errors   = array_merge($DML->getErrors(), $this->errors);
        $this->numrows  = $DML->getNumRows();

        return $array;

    } // _dml_ReadBeforeUpdate

    // ****************************************************************************
    function _dml_updateRecord ($fieldarray, $oldarray, $where=null)
    // update the record contained in $fieldarray.
    {
        $DML =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        // use ORIGINAL, not CURRENT specifications for this database table
        $DML->fieldspec     = $this->getFieldSpec_original();
        $DML->primary_key   = $this->getPkeyNames();
        $DML->unique_keys   = $this->unique_keys;
        $DML->audit_logging = $this->audit_logging;

        $DML->updateRecord($this->dbname, $this->tablename, $fieldarray, $oldarray, $where);

        $this->errors  = array_merge($DML->getErrors(), $this->errors);
        $this->numrows = $DML->getNumRows();

        return;

    } // _dml_updateRecord

    // ****************************************************************************
    function _dml_updateSelection ($selection, $replace)
    // update a selection of records in a single operation.
    {
        $DML =& $this->_getDBMSengine($this->dbms_engine, $this->dbname);

        $DML->fieldspec     = $this->fieldspec;
        $DML->audit_logging = $this->audit_logging;

        if (!$this->audit_logging) {
            // no audit logging, so update everything in one operation
            $count = $DML->updateSelection($this->dbname, $this->tablename, $replace, $selection);
            $this->errors = array_merge($DML->getErrors(), $this->errors);
        } else {
            $this->sqlSelectInit();
            // audit logging is ON, so fetch everything and update one row at a time
            $resource = $this->getData_batch($selection);
            $count    = $this->numrows;
            $errors   = array();
            while ($row = $this->fetchRow($resource)) {
                $update = where2array($replace);
                $update = array_merge($row, $update);
                // construct primary key for original record as this may be changed in this update
                $where  = array2where($row, $this->primary_key);
            	$this->_dml_updateRecord($update, $row, $where);
            	$errors = array_merge($this->getErrors(), $errors);
            } // while
            $this->errors = $errors;
        } // if

        $this->numrows = $count;

        return $count;

    } // _dml_updateSelection

    // ****************************************************************************
    function _examineWorkflow ($input)
    // a task has just completed, so ...
    // find out if this task/context starts a new workflow instance (case),
    // or is a workitem within an existing workflow instance.
    {
        $this->errors = array();

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
        if (!empty($this->wf_context)) {
            // replace current context with saved workitem context
        	$context = $this->wf_context;
        } // if

        // interface with the workflow engine
        $workflow =& singleton::getInstance('workflow_engine');

        // look to see if this task is a workitem within an existing workflow case
        if (isset($wf_case_id) and isset($wf_workitem_id)) {
            // yes it is, so mark it as finished
            $workflow->finishWorkItem($wf_case_id, $wf_workitem_id, $context, $fieldarray);
            if ($workflow->errors) {
                $this->errors = array_merge($this->errors, $workflow->getErrors());
                return $this->errors;
            } // if
            return;
        } // if

        // look to see if this task requires the starting of a new workflow case
        $wf_case_id = $workflow->startWorkflowCase($GLOBALS['task_id'], $context);
        if ($workflow->errors) {
            $this->errors = array_merge($this->errors, $workflow->getErrors());
            return $this->errors;
        } // if

        return $this->errors;

    } // _examineWorkflow

    // ****************************************************************************
    function _examineWorkflowInstance ($where)
    // a task has just started, so ...
    // look to see if this task/context is a workitem within a workflow instance,
    // and if it is then set the appropriate variables (for use in finishWorkItem())
    {
        if (empty($where)) {
            // no context yet, so ignore
            return;
        } // if

        $this->errors = array();

        // look for a workitem that matches this task_id and context
        $dbworkitem =& singleton::getInstance('wf_workitem');

        $context = addslashes(trim($where, ' ()'));
        //$workitem_where = "task_id='{$GLOBALS['task_id']}' AND context='$context'";
        // use 'LIKE' as the passed context may have been trimmed
        $workitem_where = "task_id='{$GLOBALS['task_id']}' AND context LIKE '$context%'";
        if (isset($GLOBALS['batch']) AND is_True($GLOBALS['batch'])) {
        	$workitem_where .= "  AND workitem_status='IP'"; // 'in progress'
        } else {
            $workitem_where .= "  AND workitem_status='EN'"; // 'enabled'
        } // if
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
        reset($workitem_data);   // fix for version 4.4.1
        $workitem_data = $workitem_data[key($workitem_data)];

        if (isset($GLOBALS['batch']) AND is_True($GLOBALS['batch'])) {
            // ignore next check
        } else {
            // check that workitem has been assigned to this user's role
            if ($workitem_data['role_id'] != $_SESSION['role_id']) {
                //scriptPrevious("This task has been assigned to role " .$workitem_data['role_id']);
                $batch_errors = scriptPrevious(getLanguageText('sys0014', $workitem_data['role_id']));
                return $batch_errors;
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
                    $batch_errors = scriptPrevious(getLanguageText('sys0015', $workitem_data['user_id']));
                    return $batch_errors;
                } // if
            } // if
        } // if

        // workitem exists, so store details
        $this->wf_case_id     = $workitem_data['case_id'];
        $this->wf_workitem_id = $workitem_data['workitem_id'];

        if (addslashes($workitem_data['context']) != $context) {
            // current primary key does not match workitem context, so ...
            // workitem context must be saved and carried forward
            $this->wf_context = $workitem_data['context'];
        } else {
        	$this->wf_context = null;
        } // if

        return;

    } // _examineWorkflowInstance

    // ****************************************************************************
    function &_getDBMSengine ($engine, $dbname=null)
    // get/create the object that deals with this database engine.
    {
        if (empty($engine)) {
        	trigger_error("No value has been supplied for DBMS engine", E_USER_ERROR);
        } // if

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
            } elseif ($engine == 'oracle') {
                if (version_compare(phpversion(), '5.0.0', '<')) {
                    // use old api's
                    require_once "dml.oracle.php4.class.inc";
                } else {
                    // use new api's
                    require_once "dml.oracle.php5.class.inc";
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
    function _sqlAssembleWhere ($where, $where_array)
    // assemble the $where clause from its component parts.
    // ($where = string, $where_array = array)
    {
        if (is_True($this->is_link_table)) {
            // this is for an outer-link-inner relationship
            $where = $this->_sqlAssembleWhereLink($where, $where_array);
        } // if

        if ($this->checkPrimaryKey or empty($this->sql_from) or ($this->sql_from == $this->tablename)) {
            // check that 'where' clause does not contain any fields that
            // are not in this table, otherwise it will cause an error
            $where = whereFilter($where, $this->fieldspec, $this->tablename);
        } // if

        if (empty($this->sql_from)) {
            // obtain fields from foreign tables via a JOIN, if necessary
            $this->sql_from = $this->_sqlForeignJoin($this->sql_select, $this->sql_from, $this->parent_relations);
        } // if

        if (!empty($this->sql_search)) {
            // turn 'current/historic/future' into a range of dates
            $this->sql_search = currentOrHistoric($this->sql_search);
        } // if

        if (empty($this->sql_from) or $this->sql_from == $this->tablename) {
            // check that 'search' clause does not contain any fields that
            // are not in this table, otherwise it will cause an error
            $this->sql_search = whereFilter($this->sql_search, $this->fieldspec, $this->tablename);
            //$this->sql_orderby = orderbyFilter($this->sql_orderby, $this->fieldspec, $this->tablename);
        } // if

        if (!empty($this->sql_from)) {
            // qualify each column name to avoid conflict with other tables
            $where           = qualifyWhere($where, $this->tablename, $this->fieldspec, $this->sql_from);
            $this->sql_where = qualifyWhere($this->sql_where, $this->tablename, $this->fieldspec, $this->sql_from);
        } // if

        if (!empty($this->sql_search)) {
            $search_array = where2array($this->sql_search, false, false);
            if (!empty($this->link_item)) {
                if (isset($search_array['selected'])) {
                	// replace 'selected' with correct column name, testing for T/Y and F/N
                    $search_array['selected'] = stripOperators($search_array['selected']);
                    if (is_True($search_array['selected'])) {
                    	$search_array[$this->link_item] = 'IS NOT NULL';
                    } else {
                        $search_array[$this->link_item] = 'IS NULL';
                    } // if
                    // ensure that 'selected' column is not specified in search criteria
                    unset($search_array['selected']);
                    $this->sql_search = array2where($search_array);
                } // if
            } // if

            if (!empty($this->sql_search)) {
                // qualify each column name to avoid conflict with other tables
                $this->sql_search = qualifyWhere($this->sql_search, $this->tablename, $this->fieldspec, $this->sql_from, $this->sql_search_table);
                // merge $where with optional search criteria
                if (!empty($this->sql_search)) {
                    if (empty($where)) {
                        $where = $this->sql_search;
                    } else {
                        $where .= ' AND ' .$this->sql_search;
                    } // if
                } // if
                $where_array = where2indexedArray($where);
            } // if
        } // if

        if (!empty($this->sql_from) AND !empty($this->default_orderby)) {
            // qualify $default_orderby using one of two possible table names
            if (isset($this->sql_orderby_table)) {
                $orderby_table = $this->sql_orderby_table;
            } else {
                $orderby_table = $this->tablename;
            } // if
            if ($orderby_table != $this->tablename) {
                if (file_exists("classes/$orderby_table.class.inc")) {
                	require_once "classes/$orderby_table.class.inc";
                    $dbobject  = new $orderby_table;
                    $fieldspec = $dbobject->fieldspec;
                } else {
                    // look for 'original AS alias' in sql_from string
                    $alias_tablename = getTableAlias1($orderby_table, $this->sql_from);
                    if ($alias_tablename) {
                    	require_once "classes/$alias_tablename.class.inc";
                        $dbobject  = new $alias_tablename;
                        $fieldspec = $dbobject->fieldspec;
                    } else {
                        $fieldspec = array();
                    } // if
                } // if
            } else {
                $fieldspec = $this->fieldspec;
            } // if
            $this->default_orderby = qualifyOrderby($this->default_orderby, $orderby_table, $fieldspec);
        } // if

        // the 'where' sring may come in two parts
        if (empty($this->sql_where)) {
            $where_str = $where;
        } else {
            // incorporate optional 'sql_where' criteria
            if (!empty($where)) {
                //$where_str = "$where AND $this->sql_where";
                $where_str = mergeWhere($this->sql_where, $where);
            } else {
                $where_str = $this->sql_where;
            } // if
        } // if

        return $where_str;

    } // _sqlAssembleWhere

    // ****************************************************************************
    function _sqlAssembleWhereLink ($where, $where_array)
    // in a many-link-many relationship this will assemble the SQL commands for
    // the middle (link) table.
    {
        if (isset($this->link_item)) {
            // this has already been processed, so don't do it again
            return $where;
        } // if

        reset($where_array);   // fix for version 4.4.1
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
        $this->sql_orderby_table    = $this->inner_table;

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

        $this->link_item = $this->tablename .'.' .$fldchild;

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
            if (isset($reldata['parent_field'])) {
            	$sql_select .= $reldata['parent_field'];
            } // if
        } // if
        $sql_select = rtrim($sql_select, ', ');

        $this->sql_select = $sql_select .", CASE WHEN $this->link_item IS NULL THEN 'F' ELSE 'T' END AS selected";

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
        // remove last 5 characters (' AND ')
        $sql_from = substr($sql_from, 0, strlen($sql_from) - 5);
        $sql_from .= ')';

        $this->sql_from = $sql_from .' ' .$this->sql_from;

        return $where;

    } // _sqlAssembleWhereLink

    // ****************************************************************************
    function _sqlForeignJoin (&$select, $from, $parent_relations)
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
                $parent_table = $reldata['parent'];
                $parent_field = $reldata['parent_field'];
                // does this belong to another database/schema?
                if (isset($reldata['dbname'])) {
                    // enclose $dbname in quotes to deal with non-standard characters
                    $dbname = '"' .$GLOBALS['dbprefix'] .$reldata['dbname'] .'"' .'.';
                } else {
                    $dbname = '';
                } // if
                // does this table have an alias?
                if (isset($reldata['alias'])) {
                    $alias = $reldata['alias'];
                } else {
                    $alias = '';
                } // if
                // obtain $fieldspec array for relevant table ($this or another)
                if ($parent_table != $this->tablename) {
                    if (!class_exists($parent_table)) {
                    	require_once "classes/$parent_table.class.inc";
                    } // if
                    $dbobject = new $parent_table;
                    $fieldspec      = $dbobject->fieldspec;
                } else {
                    $fieldspec      = $this->fieldspec;
                } // if
                // put parent field(s) from foreign table into SELECT area
                if (isset($reldata['alias'])) {
                    $parent_field = qualifySelect($parent_field, $reldata['alias'], $fieldspec);
                } else {
                    $parent_field = qualifySelect($parent_field, $reldata['parent'], $fieldspec);
                } // if
                $select .= ', ' .$parent_field;
                // build JOIN using supplied field names
                if (!empty($alias)) {
                    $from .= ' LEFT JOIN ' .$dbname .$reldata['parent']  .' AS ' .$alias .' ON (';
                } else {
                    $from .= ' LEFT JOIN ' .$dbname .$reldata['parent']  .' ON (';
                } // if
                foreach ($reldata['fields'] as $fldchild => $fldparent) {
                    if (strlen($fldchild) < 1) {
                        // 'Name of child field missing in relationship with $parent_table'
                        trigger_error(getLanguageText('sys0110', strtoupper($parent_table)), E_USER_ERROR);
                    } // if
                    if (strlen($fldparent) < 1) {
                        // 'Name of parent field missing in relationship with $parent_table'
                        trigger_error(getLanguageText('sys0112', strtoupper($parent_table)), E_USER_ERROR);
                    } // if
                    if (!empty($alias)) {
                        $from .= $alias .'.' .$fldparent .'=' .$this->tablename .'.' .$fldchild .' AND ';
                    } else {
                        $from .= $reldata['parent'] .'.' .$fldparent .'=' .$this->tablename .'.' .$fldchild .' AND ';
                    } // if
                } // foreach
                // remove last 5 characters (' AND ')
                $from = substr($from, 0, strlen($from) - 5);
                $from .= ')';
            } // if
        } // foreach

        return $from;

    } // _sqlForeignJoin

    // ****************************************************************************
    function _validateInsert ($fieldarray)
    // validate contents of $fieldarray prior to an INSERT
    {
        $validationobj =& singleton::getInstance('validation_class');

        $array = $validationobj->validateInsert($fieldarray, $this->fieldspec, $this);

        $this->errors = $validationobj->getErrors();

        return $array;

    } // _validateInsert

    // ****************************************************************************
    function _validateUpdate ($fieldarray)
    // validate contents of $fieldarray prior to an UPDATE
    {
        $validationobj =& singleton::getInstance('validation_class');

        $array = $validationobj->validateUpdate($fieldarray, $this->fieldspec, $this);

        $this->errors = $validationobj->getErrors();

        return $array;

    } // _validateUpdate

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