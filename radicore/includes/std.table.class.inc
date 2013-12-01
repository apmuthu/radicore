<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2013 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

class Default_Table
{
    // member variables
    var $access_count;                  // count of accesses since instantiation
    var $allow_empty_where = false;     // switch to allow an empty $where string in STD.LIST2.INC
    var $allow_db_function = array();   // allow a field's value in a database insert/update to contain a function name
    var $alt_language_table;            // table holding alternative language text
    var $alt_language_cols;             // columns holding alternative language text
    var $audit_logging;                 // yes/no switch

    var $checkPrimaryKey = false;       // yes/no switch
    var $child_relations = array();     // child relationship specifications (optional)
    var $css_files = array();           // optional CSS file names
    var $csv;                           // object for CSV processing
    var $custom_processing_object;      // name of object containing code for custom processing
    var $custom_replaces_standard;      // if set to TRUE in a custom method then the standard method must not be run

    var $dbms_engine;                   // database engine (mysql, postgresql, oracle, etc)
    var $dbname;                        // database name
    var $dbname_old;                    // refer to _switch_database() method
    var $dbprefix;                      // prefix (for shared servers)
    var $dirname;                       // directory name of current script
    var $dirname_dict;                  // directory name where '*.dict.inc' script is located (optional)

    var $download_filename;             // file to be downloaded
    var $download_mode;                 // 'inline' or null

    var $delete_count;                  // count of records deleted
    var $insert_count;                  // count of records inserted
    var $update_count;                  // count of records updated
    var $unchange_count;                // count of records unchanged

    var $errors = array();              // array of errors
    var $expanded;                      // list of tree nodes which have been expanded
    var $fieldarray = array();          // array of row/field data
    var $fieldspec = array();           // field specifications (see class constructor)
    var $fields_not_for_trimming = array();     // array of field names which are not to be trimmed
    var $field_access;                  // see setFieldAccess()
    var $ignore_empty_fields = false;   // YES/NO switch (see getInitialData() method)
    var $initial_values;                // from MNU_INITIAL_VALUES_USER/ROLE
    var $initiated_from_controller = false;     // source of object instantiation
    var $inner_table;                   // used in an outer-link-inner relationship
    var $instruction;                   // instruction to be passed to previous script
    var $is_link_table = false;         // used in method _sqlAssembleWhere (many-link-many relationship)
    var $javascript = array();          // optional JavaScript code
    var $lastpage;                      // last available page number in current query
    var $link_item;                     // used in _sqlAssembleWhere() in many-to-many relationships
    var $lookup_data = array();         // array of lookup data (for dropdowns, radio groups)
    var $lookup_css = array();          // optional css classes for $lookup_data
    var $messages = array();            // array of messages
    var $nameof_end_date;               // alias for 'end_date'
    var $nameof_start_date;             // alias for 'start_date'
    var $no_controller_msg = false;     // prevent page controller from creating a message concerning this object
    var $no_csv_header = false;         // turns off creation of header row in CSV output file
    var $no_display_count = false;      // yes/no switch to display count after multiple inserts or updates
    var $no_duplicate_error = false;    // if TRUE do not create an error when inserting a duplicate
    var $no_foreign_data = false;       // if TRUE do not call getForeignData() method
    var $no_submit_on_error = false;    // if TRUE drop any SUBMIT buttons after a validation error
    var $numrows;                       // number of rows retrieved
    var $outer_table;                   // used in an outer-link-inner relationship
    var $pageno;                        // requested page number
    var $parent_relations = array();    // parent relationship specifications (optional)

    var $parent_object;                 // reference to parent object (if there is one in current task)
    var $child_object;                  // reference to child object  (if there is one in current task)

    var $pdf;                           // object for PDF processing
    var $pdf_filename;                  //
    var $pdf_destination;               // I=Inline (browser), D=Download (browser), F=Filename (on server), S=String

    var $picker_subdir;                 // subdirectory for the File Picker
    var $picker_filetypes = array();    // array of file types

    var $primary_key = array();         // column(s) which form the primary key
    var $report_structure;              // report structure
    var $resize_array;                  // used in file uploads
    var $retry_on_duplicate_key;        // field name to be incremented when insert fails
    var $reuse_previous_select = false; // reuse previous SELECT in _dml_ReadBeforeUpdate()
    var $rows_per_page = 0;             // page size for multi-row forms
    var $row_locks;                     // FALSE, SH=shared, EX=exclusive
    var $row_locks_supp;                // supplemental lock type
    var $scrollarray;                   // array for internal scrolling
    var $scrollindex;                   // index to current item in scrollarray
    var $select_string;                 // identifies which entries have been selected
    var $skip_getdata = false;          // YES/NO switch
    var $skip_validation = false;       // YES/NO switch
    var $tablename;                     // table name (internal)
    var $transaction_level;             // transaction level
    var $unbuffered_query = false;      // used in getData_serial()
    var $unique_keys = array();         // unique key specifications (optional)
    var $update_on_duplicate_key=false; // switch to 'update' if insert fails

    var $upload_subdir;                 // subdirectory for file upoads
    var $upload_filetypes = array();    // file types for uploading
    var $upload_maxfilesize;            // max file size for uploading

    var $wf_case_id;                    // workflow case id
    var $wf_context;                    // workitem context
    var $wf_workitem_id;                // workflow workitem id

    var $xsl_params = array();          // optional parameters to be passed to XSL transformation

    var $zone;                          // set by page controller - main/outer/middle/inner

    // the following are used to construct SQL queries
    var $default_orderby = null;        // default for table, may be overridden by $sql_orderby
    var $default_orderby_task = null;   // default for task, may be overridden by $sql_orderby
    var $sql_from;
    var $sql_groupby;
    var $sql_having;
    var $sql_no_foreign_db = false;     // if TRUE _sqlProcessJoin() method will skip tables in other databases
    var $sql_orderby;                   // sort field
    var $prev_sql_orderby;              // previous sort field
    var $sql_orderby_seq;               // 'asc' or 'desc'
    var $sql_orderby_table;             // tablename qualifier for optional sort criteria
    var $sql_search;                    // optional search criteria from a search screen (modifiable)
    var $sql_search_orig;               // original search criteria (unmodified)
    var $sql_search_table;              // tablename qualifier for optional search criteria
    var $sql_select;                    // fields to be selected
    var $sql_selection;                 // selection passed down from previous task
    var $sql_union;                     // optional UNION clause
    var $sql_where;                     // additional selection criteria
    var $where;                         // passed from parent form

    // ****************************************************************************
    // class constructor
    // ****************************************************************************
    function Default_Table ()
    {
        // save directory name of current script
        //$this->dirname   = dirname(__file__);

        $this->dbms_engine = '';            // to be supplied by getFieldSpec_original()
        $this->dbprefix    = '';            // to be supplied by getFieldSpec_original()
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
        $DML =& $this->_getDBMSengine($this->dbname);

        if (is_string($array)) {
            return $array;
        } // if

        $string = $DML->array2string($array);

        return $string;

    } // array2string

    // ****************************************************************************
    function cascadeDelete ($where, $parent_table=null)
    // Parent record is being deleted, so remove associated records from this table.
    {
        $errors = array();
        $this->delete_count = null;

        // retrieve all records which match criteria in $where
        $fieldarray = $this->getData_raw($where);
        $errors = array_merge($errors, $this->errors);

        // now delete them one at a time
        $count = 0;
        foreach ($fieldarray as $rowdata) {
            $rowdata = $this->_cm_pre_cascadeDelete($rowdata);
            $rowdata = $this->deleteRecord($rowdata, $parent_table);
            if (!empty($this->errors)) {
                foreach ($this->errors as $error) {
                    $errors[] = "$this->tablename - $error";
                } // foreach
                break;
            } // if
            $count++;
        } // foreach
        unset($fieldarray);

        if (count($errors) > 0) {
            $this->errors = $errors;
            return false;
        } // if

        // save count so that values may be accumulated
        $this->delete_count[strtoupper($this->tablename)] = $count;

        // $count rows were deleted
        return $this->getLanguageText('sys0004', $count, strtoupper($this->tablename));

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

        if (preg_match('/^(workflow|audit)$/i', $this->dbname) OR defined('TRANSIX_NO_WORKFLOW') OR defined('RADICORE_NO_WORKFLOW')) {
            // do nothing
        } else {
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
                if ($field == 'curr_or_hist') {
                    // reset to 'current' dates (the default)
                    $fieldarray[$field] = 'C';
                } elseif (array_key_exists('noedit', $fieldspec[$field])) {
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

        $this->sql_union = null;

        if (preg_match('/^(workflow|audit)$/i', $this->dbname) OR defined('TRANSIX_NO_WORKFLOW') OR defined('RADICORE_NO_WORKFLOW')) {
            // do nothing
        } else {
            // if this task+context is a pending workitem then update it
            $errors = $this->_examineWorkflow($this->fieldarray);
        } // if

        $DML =& $this->_getDBMSengine($this->dbname);
        if ($errors) {
            $result = $DML->rollback($this->dbname);
        } else {
            if ($result = $DML->commit($this->dbname)) {
                // update has been committed, so remove any 'run_at_cancel' reference
                if ($this->initiated_from_controller) {
                    if (isset($GLOBALS['script_vars']['task_id_run_at_cancel'])) {
                        unset($GLOBALS['script_vars']['task_id_run_at_cancel']);
                        unset($GLOBALS['script_vars']['task_id_run_at_cancel_context']);
                    } // if
                    $script_vars = updateScriptVars($GLOBALS['script_vars']);
                } // if
            } else {
                $errors[] = $this->getLanguageText('sys0009'); // 'Commit failed'
            } // if
        } // if

        $GLOBALS['transaction_has_started'] = FALSE;

        return $errors;

    } // commit

    // ****************************************************************************
    function convertTimeZone ($fieldarray)
    // convert any datetime fields from client timezone to server timezone.
    {
        if (empty($_SESSION['timezone_server']) OR empty($_SESSION['timezone_client'])) {
            return $fieldarray;  // nothing to do
        } // if

        foreach ($this->fieldspec as $field => $spec) {
            if (preg_match('/(datetime|timestamp)/i', $spec['type'])) {
                $fieldarray[$field] = convertTZ($fieldarray[$field],
                                                $_SESSION['timezone_client'],
                                                $_SESSION['timezone_server']);
            } // if
        } // foreach

        return $fieldarray;

    } // convertTimeZone

    // ****************************************************************************
    function currentOrHistoric ($string, $start_date='start_date', $end_date='end_date')
    // convert the string 'current/historic/future' into a date range.
    // NOTE: defaults to fields named START_DATE and END_DATE, but this may be changed.
    {
        if (empty($start_date)) {
            $start_date = 'start_date';
        } // if
        if (empty($end_date)) {
            $end_date = 'end_date';
        } // if

        // convert search string into an indexed array
        $search = where2array($string, false, false);

        if (isset($search['curr_or_hist'])) {
            // replace Current/Historic/Future with a range of dates
            $search1 = stripOperators($search);

            // check that $start_date and $end_date exist in this table
            if (!array_key_exists($start_date, $this->fieldspec) OR !array_key_exists($end_date, $this->fieldspec)) {
                $search1['curr_or_hist'] = 'invalid';
            } else {
                $today = getTimeStamp('date');
                switch ($search1['curr_or_hist']) {
                    case 'C':
                        // search for records with CURRENT dates
                        $search[$start_date] = "<='$today 23:59:59'";
                        $search[$end_date]   = ">='$today 00:00:00'";
                        break;
                    case 'H':
                        // search for records with HISTORIC dates
                        $search[$end_date] = "<'$today 00:00:00'";
                        break;
                    case 'F':
                        // search for records with FUTURE dates
                        $search[$start_date] = ">'$today 23:59:59'";
                    default:
                        ;
                } // switch
            } // if

            // rebuild search string without 'curr_or_hist' flag
            unset($search['curr_or_hist']);
            $string = array2where($search);
        } // if

        return $string;

    } // currentOrHistoric

    // ****************************************************************************
    function customButton ($fieldarray, $button, $postarray, $row=null)
    // user pressed a custom button.
    {
        if ($this->errors) {
            return $this->getFieldArray();  // object has unresolved errors, so do nothing
        } // if

        // filter out any data which does not belong in this table
        $postarray = getPostArray($postarray, $this->fieldspec);

        if (!is_long(key($fieldarray))) {
            $fieldarray = array($fieldarray);  // ensure it is indexed by row
        } // if

        if ($this->rows_per_page == 1) {
            // this is the only row
            $row = 0;
            $fieldarray = array_update_associative($fieldarray[$row], $postarray, $this->fieldspec);
            $output     = $this->_cm_customButton($fieldarray, $button);
        } else {
            // this is one of many rows
            if (empty($row)) $row=1;  // default
            $row = $row-1;  // screen rows start at #1 while database rows start at zero
            if (array_key_exists($row, $fieldarray)) {
                $fieldarray  = array_update_indexed($fieldarray, $postarray, $this->fieldspec);
                $output      = $this->_cm_customButton($fieldarray[$row], $button);
            } // if
        } // if

        reset($output);
        if (is_long(key($output))) {
            // output is indexed, so replace entire array
            $this->fieldarray = $output;
        } else {
            // output is associative, so replace single row
            if ($this->rows_per_page == 1) {
                $this->fieldarray = array($row => $output);
            } else {
                $this->fieldarray[$row] = $output;
            } // if
        } // if

        if (count($this->fieldarray == 1)) {
            if (empty($this->fieldarray[key($this->fieldarray)])) {
                $this->fieldarray = array();  // contains a single empty element, so clear it out
            } // if
        } // if

        // see if any additional data is required or needs to be changed
        $this->fieldarray = $this->getExtraData($this->fieldarray);

        return $this->getFieldArray();

    } // customButton

    // ****************************************************************************
    function deleteMultiple ($fieldarray)
    // delete multiple records using data in $fieldarray.
    {
        $errors = array();
        $this->no_display_count = false;
        $count                  = 0;

        if (isset($GLOBALS['batch']) AND is_True($GLOBALS['batch'])) {
            // check to see if this task is a pending workitem
            $errors = $this->checkWorkflow($fieldarray[0]);
            if ($errors) {
                return $fieldarray;
            } // if
        } // if

        if (empty($this->errors)) {
            // perform any additional custom pre-processing
            if (is_object($this->custom_processing_object)) {
                if (method_exists($this->custom_processing_object, '_cm_pre_deleteMultiple')) {
                    $fieldarray = $this->custom_processing_object->_cm_pre_deleteMultiple($fieldarray);
                } // if
            } // if
            if ($this->custom_replaces_standard) {
                $this->custom_replaces_standard = false;
            } else {
                $fieldarray = $this->_cm_pre_deleteMultiple($fieldarray);
            } // if
        } // if

        if (!$this->errors) {
            // delete each row one by one
            foreach ($fieldarray as $rownum => $row) {
                $row = $this->deleteRecord($row);
                if (!empty($this->errors)) {
                    // accumulate all errors
                    //$errors = array_merge($errors, $this->errors);
                    $errors[$rownum] = $this->errors;
                } else {
                    $count = $count + $this->numrows;
                } // if
            } // foreach

            if (empty($this->errors)) {
                // perform any additional custom post-processing
                if (is_object($this->custom_processing_object)) {
                    if (method_exists($this->custom_processing_object, '_cm_post_deleteMultiple')) {
                        $fieldarray = $this->custom_processing_object->_cm_post_deleteMultiple($fieldarray);
                    } // if
                } // if
                if ($this->custom_replaces_standard) {
                    $this->custom_replaces_standard = false;
                } else {
                    $fieldarray = $this->_cm_post_deleteMultiple($fieldarray);
                } // if
            } // if

        } // if

        if (is_True($this->no_display_count)) {
            // do not display record count
        } else {
            // '$count records were deleted from $tablename'
            $this->messages[] = $this->getLanguageText('sys0004', $count, strtoupper($this->tablename));
        } // if

        $this->errors  = $errors;
        $this->numrows = $count;

        return $fieldarray;

    } // deleteMultiple

    // ****************************************************************************
    function deleteRecord ($fieldarray, $parent_table=null)
    // delete the record specified in $fieldarray.
    // ($parent_table is only used in a cascade delete)
    {
        $this->errors = array();   // initialise

        if (empty($fieldarray)) {
            return $fieldarray;    // nothing to delete
        } // if

        if (is_string($fieldarray)) {
            // convert from string to array
            $fieldarray = where2array($fieldarray);
        } // if

        // shift all field names to lower case
        $fieldarray = array_change_key_case($fieldarray, CASE_LOWER);

        if (!$this->skip_getdata) {
            // check that full primary key (or candidate key) has been supplied
            list($where, $errors) = isPkeyComplete($fieldarray, $this->getPkeyNames(), $this->unique_keys);
            if (!empty($errors)) {
                $this->errors = $errors;
            } // if

            if (empty($this->errors)) {
                // obtain copy of original record from database
                $where = array2where($fieldarray, $this->getPkeyNames(), $this);
                $originaldata = $this->_dml_ReadBeforeUpdate($where);
                if ($this->numrows == 0) {
                    return $fieldarray;  // there is nothing to delete
                } elseif ($this->numrows == 1) {
                    // use only 1st row in $originaldata
                    $originaldata = $originaldata[0];
                    // insert non-key values for inclusion in audit log
                    $fieldarray = array_merge($fieldarray, $originaldata);
                    if (!empty($this->unique_keys)) {
                        // rebuild $where from pkey in case candidate key was used
                        $where = array2where($fieldarray, $this->getPkeyNames(), $this);
                    } // if
                } else {
                    // more than 1 record found - key is not unique
                    $this->errors[] = $this->getLanguageText('sys0113');
                } // if
            } // if
        } // if

        // check that this record can be deleted
        $numrows = $this->numrows;
        if (empty($this->errors)) {
            $fieldarray = $this->validateDelete($fieldarray, $parent_table);
        } // if

        if (empty($this->errors)) {
            // perform any custom pre-delete processing
            if (is_object($this->custom_processing_object)) {
                if (method_exists($this->custom_processing_object, '_cm_pre_deleteRecord')) {
                    $fieldarray = $this->custom_processing_object->_cm_pre_deleteRecord($fieldarray);
                } // if
            } // if
            if ($this->custom_replaces_standard) {
                $this->custom_replaces_standard = false;
            } else {
                $fieldarray = $this->_cm_pre_deleteRecord($fieldarray);
            } // if
        } // if

        if (empty($this->errors)) {
            // delete any tables related to the specified record
            $this->deleteRelations($fieldarray);
        } // if

        $this->numrows = $numrows;
        if (empty($this->errors) AND $this->numrows > 0) {
            // delete the specified record
            $this->_dml_deleteRecord($fieldarray);
        } // if

        if (empty($this->errors)) {
            // perform any custom post-delete processing
            if (is_object($this->custom_processing_object)) {
                if (method_exists($this->custom_processing_object, '_cm_post_deleteRecord')) {
                    $fieldarray = $this->custom_processing_object->_cm_post_deleteRecord($fieldarray);
                } // if
            } // if
            if ($this->custom_replaces_standard) {
                $this->custom_replaces_standard = false;
            } else {
                $fieldarray = $this->_cm_post_deleteRecord($fieldarray);
            } // if
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
            switch (strtoupper($reldata['type'])) {
                case 'NULLIFY':
                case 'NUL':
                    // set foreign key(s) to null
                    $where = NULL;
                    $update_array = array();
                    foreach ($reldata['fields'] as $fldparent => $fldchild) {
                        //if (strlen($fldchild) < 1) {
                        //    // 'Name of child field missing in relationship with $tblchild'
                        //    $this->errors[] = $this->getLanguageText('sys0110', strtoupper($tblchild));
                        //    break;
                        //} // if
                        if (!empty($fldchild)) {
                            if (empty($where)) {
                                $where = "$fldchild='" .addslashes($fieldarray[$fldparent]) ."'";
                            } else {
                                $where .= " AND $fldchild='" .addslashes($fieldarray[$fldparent]) ."'";
                            } // if
                        } // if
                        $update_array[$fldchild] = NULL;
                    } // foreach

                    if (empty($where)) {
                        // 'Name of child field missing in relationship with $tblchild'
                        $this->errors[] = $this->getLanguageText('sys0110', strtoupper($tblchild));
                        break;
                    } else {
                        // instantiate an object for this table
                        if (array_key_exists('subsys_dir', $reldata)) {
                            // get path to current subsystem directory
                            $dir = dirname($this->dirname);
                            // switch to other subsystem directory
                            $dir = dirname($dir) .'/' .$reldata['subsys_dir'] .'/';
                        } else {
                            $dir = NULL;
                        } // if
                        if (!class_exists($tblchild)) {
                            require_once $dir ."classes/$tblchild.class.inc";
                        } // if
                        $childobject = new $tblchild;
                        if (!empty($this->dbname_old) AND $this->dbname_old == $childobject->dbname) {
                            // name of parent database has been switched, so switch the child name as well
                            $childobject->dbname_old = $childobject->dbname;
                            $childobject->dbname     = $this->dbname;
                        } // if
                        $childobject->audit_logging     = $this->audit_logging;
                        $childobject->sql_no_foreign_db = $this->sql_no_foreign_db;
                        // now use this object to delete child records
                        if (!$childobject->cascadeNullify($update_array, $where)) {
                            $this->errors = array_merge($childobject->getErrors(), $this->errors);
                        } // if
                        unset($childobject);
                    } // if
                    break;

                case 'DELETE';
                case 'DEL':
                case 'CASCADE':
                case 'CAS':
                    // delete all related rows
                    $where = NULL;
                    foreach ($reldata['fields'] as $fldparent => $fldchild) {
                        //if (strlen($fldchild) < 1) {
                        //    // 'Name of child field missing in relationship with $tblchild'
                        //    $this->errors[] = $this->getLanguageText('sys0110', strtoupper($tblchild));
                        //    break;
                        //} // if
                        if (!empty($fldchild)) {
                            if (empty($where)) {
                                $where = "$fldchild='" .addslashes($fieldarray[$fldparent]) ."'";
                            } else {
                                $where .= " AND $fldchild='" .addslashes($fieldarray[$fldparent]) ."'";
                            } // if
                        } // if
                    } // foreach

                    if (empty($where)) {
                        // 'Name of child field missing in relationship with $tblchild'
                        $this->errors[] = $this->getLanguageText('sys0110', strtoupper($tblchild));
                        break;
                    } else {
                        // instantiate an object for this table
                        if (array_key_exists('subsys_dir', $reldata)) {
                            // get path to current subsystem directory
                            $dir = dirname($this->dirname);
                            // switch to other subsystem directory
                            $dir = dirname($dir) .'/' .$reldata['subsys_dir'] .'/';
                        } else {
                            $dir = NULL;
                        } // if
                        if (!class_exists($tblchild)) {
                            require_once $dir ."classes/$tblchild.class.inc";
                        } // if
                        $childobject = new $tblchild;
                        if (!empty($this->dbname_old) AND $this->dbname_old == $childobject->dbname) {
                            // name of parent database has been switched, so switch the child name as well
                            $childobject->dbname_old = $childobject->dbname;
                            $childobject->dbname     = $this->dbname;
                        } // if
                        $childobject->audit_logging     = $this->audit_logging;
                        $childobject->sql_no_foreign_db = $this->sql_no_foreign_db;
                        // check for 'order by' clause
                        if (isset($reldata['orderby'])) {
                            $childobject->default_orderby = $reldata['orderby'];
                        } // if
                        // now use this object to delete child records
                        if (!$msg = $childobject->cascadeDelete($where, $this->tablename)) {
                            $this->errors = array_merge($childobject->getErrors(), $this->errors);
                        } else {
                            if (!empty($childobject->delete_count) AND is_array($childobject->delete_count)) {
                                foreach ($childobject->delete_count as $table => $count) {
                                    if (isset($this->delete_count[$table])) {
                                        $this->delete_count[$table] += $count;
                                    } else {
                                        $this->delete_count[$table] = $count;
                                    } // if
                                } // foreach
                            } // if
                        } // if
                        unset($childobject);
                    } // if
                    break;

                case 'RESTRICTED':
                case 'RES':
                case 'IGN':
                    // do nothing
                    break;

                case 'DEX':
                case 'NUX':
                    // do nothing as it will be handled by a foreign key constraint
                    break;

                default:
                    // 'Unknown relation type: $type'
                    $this->errors[] = $this->getLanguageText('sys0010', $reldata['type']);
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

        if (empty($selection)) {
            // 'Nothing has been selected yet.'
            $this->errors[] = scriptPrevious($this->getLanguageText('sys0081'));
            return;
        } // if

        // call custom method for specific processing
        $msg = $this->_cm_deleteSelection($selection);

        return $msg;

    } // deleteSelection

    // ****************************************************************************
    function eraseRecord ($fieldarray)
    // delete the record, and ALL its children, specified in $fieldarray.
    {
        $this->errors = array();

        if (is_string($fieldarray)) {
            // convert from string to array
            $fieldarray = where2array($fieldarray, false, false);
        } // if

        // strip any operators from the value portion of the array
        $fieldarray = stripOperators($fieldarray);

        // check that full primary key has been supplied
        list($where, $errors) = isPkeyComplete($fieldarray, $this->getPkeyNames());
        if (!empty($errors)) {
            $this->errors = $errors;
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

        if (empty($this->child_relations) OR empty($fieldarray)) {
            return;
        } // if

        // process contents of $child_relations array
        foreach ($this->child_relations as $reldata) {
            $tblchild = $reldata['child'];
            if (array_key_exists('subsys_dir', $reldata)) {
                // do not erase from a database in another subsystem
            } else {
                switch (strtoupper($reldata['type'])) {
                    case 'DEX':
                    case 'NUX':
                        // do nothing as it will be handled by a foreign key constraint
                        break;

                    case 'IGN':
                        // ignore this relationship
                        break;

                    case 'NULLIFY':
                    case 'NUL':
                        // set foreign key(s) to null
                        $where = NULL;
                        $update_array = array();
                        foreach ($reldata['fields'] as $fldparent => $fldchild) {
                            if (strlen($fldchild) < 1) {
                                // 'Name of child field missing in relationship with $tblchild'
                                $this->errors[] = $this->getLanguageText('sys0110', strtoupper($tblchild));
                                break;
                            } // if
                            if (empty($where)) {
                                $where = "$fldchild='" .addslashes($fieldarray[$fldparent]) ."'";
                            } else {
                                $where .= " AND $fldchild='" .addslashes($fieldarray[$fldparent]) ."'";
                            } // if
                            $update_array[$fldchild] = NULL;
                        } // foreach

                        // instantiate an object for this table
                        if (array_key_exists('subsys_dir', $reldata)) {
                            // get path to current subsystem directory
                            $dir = dirname($this->dirname);
                            // switch to other subsystem directory
                            $dir = dirname($dir) .'/' .$reldata['subsys_dir'] .'/';
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

                    case 'DELETE':
                    case 'DEL':
                    case 'CASCADE':
                    case 'CAS':
                    case 'RESTRICTED':
                    case 'RES':
                        // erase all related rows
                        $where = NULL;
                        foreach ($reldata['fields'] as $fldparent => $fldchild) {
                            if (strlen($fldchild) < 1) {
                                // 'Name of child field missing in relationship with $tblchild'
                                $this->errors[] = $this->getLanguageText('sys0110', strtoupper($tblchild));
                                break;
                            } // if
                            if (empty($where)) {
                                $where = "$fldchild='" .addslashes($fieldarray[$fldparent]) ."'";
                            } else {
                                $where .= " AND $fldchild='" .addslashes($fieldarray[$fldparent]) ."'";
                            } // if
                        } // foreach

                        // instantiate an object for this table
                        if (array_key_exists('subsys_dir', $reldata)) {
                            // get path to current subsystem directory
                            $dir = dirname($this->dirname);
                            // switch to other subsystem directory
                            $dir = dirname($dir) .'/' .$reldata['subsys_dir'] .'/';
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
                            } // if
                        } // foreach
                        unset($childobject);
                        break;

                    default:
                        // 'Unknown relation type: $type'
                        $this->errors[] = $this->getLanguageText('sys0010', $reldata['type']);
                } // switch
            } // if

        } // foreach

        if (count($this->errors) > 0) {
            return false;
        } // if

        return true;

    } // eraseRelations

    // ****************************************************************************
    function executeQuery ($query)
    // execute one or more pre-defined queries.
    {
        $DML =& $this->_getDBMSengine($this->dbname);

        $DML->setRowLocks($this->row_locks);

        $result = $DML->multiQuery($this->dbname, $this->tablename, $query);

        return $result;

    } // executeQuery

    // ****************************************************************************
    function fetchRow ($resource)
    // Fetch the next row from a resource created in the getData_serial() method.
    {
        $this->errors = array();

        if ($this->skip_getdata) {
            if (empty($this->fieldarray)) {
                $row = false;
            } else {
                $row = array_shift($this->fieldarray);
                $row = $this->_cm_post_fetchRow($row);
            } // if
            return $row;
        } // if

        $DML =& $this->_getDBMSengine($this->dbname);

        $row = $DML->fetchRow($this->dbname, $resource);

        if ($row) {
            // perform any custom post-retrieve processing
            if (is_object($this->custom_processing_object)) {
                if (method_exists($this->custom_processing_object, '_cm_post_fetchRow')) {
                    $row = $this->custom_processing_object->_cm_post_fetchRow($row);
                } // if
            } // if
            if ($this->custom_replaces_standard) {
                $this->custom_replaces_standard = false;
            } else {
                if ($row) {
                    $row = $this->_cm_post_fetchRow($row);
                } // if
            } // if
            if (empty($row)) {
                // this row has been cancelled, so read another one
                $row = $this->fetchRow($resource);
            } // if
        } // if

        return $row;

    } // fetchRow

    // ****************************************************************************
    function filePickerSelect ($selection)
    // Deal with selection from a filepicker screen.
    {
        $selection = $this->_cm_filePickerSelect($selection);

        return $selection;

    } // filePickerSelect

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
    // NOTE: $css_array is passed BY REFERENCE as it may be altered.
    {
        if (empty($fieldarray)) return $fieldarray;

        $dateobj =& RDCsingleton::getInstance('date_class');

        foreach ($fieldarray as $fieldname => $fieldvalue) {
            // only deal with fields defined in $fieldspec
            if (isset($this->fieldspec[$fieldname])) {
                // get specifications for current field
                $fieldspec = $this->fieldspec[$fieldname];
                if (!isset($fieldspec['type'])) {
                    $fieldspec['type'] = 'string';  // set default type
                } // if

                if ($GLOBALS['mode'] == 'search') {
                    if (preg_match('/^(is not null|is null)$/i', trim($fieldvalue), $regs )) {
                        $fieldvalue = strtoupper($regs[0]);
                        $fieldspec['type'] = 'string';
                        $operator = '';
                    } elseif (preg_match("/^(<>|<=|<|>=|>|!=|=)/", $fieldvalue, $regs )) {
                        $operator = $regs[0];
                        // strip operator from front of string
                        $fieldvalue = substr($fieldvalue, strlen($operator));
                        if (substr($fieldvalue, 0, 1) == "'") {
                            // remove leading quote
                            $fieldvalue = substr($fieldvalue, 1);
                        } // if
                        if (substr($fieldvalue, -1) == "'") {
                            // remove trailing quote
                            $fieldvalue = substr($fieldvalue, 0, -1);
                        } // if
                    } else {
                        $operator = '=';
                    } // if
                } else {
                    $operator = '=';
                } // if

                switch (strtolower($fieldspec['type'])) {
                    case 'string':
                        if (isset($fieldspec['control']) AND $fieldspec['control'] == 'multidrop') {
                            list($operator, $value, $delimiter) = extractOperatorValue($fieldvalue);
                            if (trim($operator) == 'IN') {
                                // turn this string into an array
                                $value = trim($value, '()');
                                $array = explode(',', $value);
                                foreach ($array as $key => $entry) {
                                    if (substr($entry, 0, 1) == "'") {
                                        // remove leading quote
                                        $entry = substr($entry, 1);
                                    } // if
                                    if (substr($entry, -1, 1) == "'") {
                                        // remove leading quote
                                        $entry = substr($entry, 0, strlen($entry)-1);
                                    } // if
                                    $array[$key] = $entry;
                                } // foreach
                                $fieldvalue = $array;
                                $operator   = '=';
                            } // if
                        } // if
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
                            $boolean = $this->getLanguageArray('boolean');
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
                                // this is already in LIKE format for a search screen. so leave it alone
                                // (apart from removing trailing '%' which will be replaced later)
                                $fieldvalue = rtrim($fieldvalue, '%');
                            } else {
                                // convert date from internal to external format
                                if ($date = $dateobj->getExternalDate($fieldvalue)) {
                                    $fieldvalue = $date;
                                } else {
                                    // date cannot be converted, so leave as is
                                } // if
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
                                if (isset($_SESSION['timezone_server'])) {
                                    $fieldvalue = convertTZ($fieldvalue, $_SESSION['timezone_server'], $_SESSION['timezone_client']);
                                } // if
                                // strip off portion which follows last ' '
                                $time = strrchr($fieldvalue, ' ');
                                $date = substr($fieldvalue, 0, strlen($fieldvalue)-strlen($time));
                                // convert date from internal to external format
                                if ($date = $dateobj->getExternalDate($date)) {
                                    $fieldvalue = trim($date) .' ' .substr(trim($time), 0, 8);
                                } else {
                                    // date cannot be converted, so leave as is
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
                    case 'integer':
                        if ($fieldvalue == 0 AND isset($fieldspec['blank_when_zero'])) {
                            if ($operator == '=') {
                                $fieldvalue = ''; // value is zero, so display blank
                            } // if
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
                           if ($operator == '=') {
                               $fieldvalue = ''; // value is zero, so display blank
                           } // if
                       } else {
                           // remove any thousands separators
                           // this screws up -> $fieldvalue = number_unformat($fieldvalue);
                           // format number according to current locale settings
                           $strip_trailing_zero =& $fieldspec['strip_trailing_zero'];
                           $fieldvalue = formatNumber($fieldvalue, $decimal_places, $strip_trailing_zero);
                       } // if
                       break;
                    default:
                        ;
                } // switch

                if (preg_match('/^(csv|pdf)/i', strtolower($GLOBALS['mode']))) {
                    if (isset($fieldspec['optionlist'])) {
                        if (empty($fieldvalue)) {
                            $fieldvalue = null;
                        } else {
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
                                        if (array_key_exists($fieldvalue, $lookup)) {
                                            $fieldvalue = $lookup[$fieldvalue];
                                        } // if
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
                        if (preg_match('/(sha1|md5)/i', $fieldspec['hash'])) {
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

            } else {
                // not in $this->fieldspec, so cannot be formatted
                $fieldarray[$fieldname] = $fieldvalue;
            } // if
        } // foreach

        // perform any custom formatting
        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_formatData')) {
                $fieldarray = $this->custom_processing_object->_cm_formatData($fieldarray, $css_array);
            } // if
        } // if
        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            $fieldarray = $this->_cm_formatData($fieldarray, $css_array);
        } // if

        return $fieldarray;

    } // formatData

    // ****************************************************************************
    function free_result ($resource)
    // free a resource created by getData_serial()
    {
        $result = $this->_dml_free_result($resource);

        return $result;

    } // free_result

    // ****************************************************************************
    function &getChildData ()
    // return $fieldarray from the child object (if there is one).
    // NOTE: output is passed by reference.
    {
        if (!is_object($this->child_object)) {
            return FALSE;
        } elseif (!method_exists($this->child_object, 'getFieldArray')) {
            return FALSE;
        } // if

        $child_data =& $this->child_object->getFieldArray();

        return $child_data;

    } // getChildData

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
    function getColumnNames ($where=null)
    // obtain list of column names which will be output with this SQL statement.
    // (this is used in 'std.output4.inc')
    {
        $this->rows_per_page = 1;

        $fieldarray = array();
        $fieldspec  = array();

        $this->lookup_data['selected'] = $this->getLanguageArray('selected');;

        $data = $this->getData($where);
        $names = $data[0];
        ksort($names);
        foreach ($names as $column => $data) {
            // each field has a 'Yes/No' dropdown with an initial value
            if (isset($this->fieldspec[$column]['autoinsert']) OR isset($this->fieldspec[$column]['autoupdate'])) {
                $fieldarray[$column] = 'N';
            } else {
                $fieldarray[$column] = 'Y';
            } // if
            $fieldspec[$column]  = array('type' => 'string',
                                         'control' => 'dropdown',
                                         'optionlist' => 'selected');
            // add this column to the screen structure
            $GLOBALS['screen_structure']['main']['fields'][] = array($column => $column, 'colspan' => 3);
        } // foreach

        // add controls for LIMIT and OFFSET
        $fieldspec['rdc_limit']  = array('type' => 'integer', 'minvalue' => 0, 'maxvalue' => 4294967295, 'required' => 'y');
        $fieldspec['rdc_offset']  = array('type' => 'integer', 'minvalue' => 0, 'maxvalue' => 4294967295, 'required' => 'y');
        $fieldarray['rdc_limit'] = 1000;
        $fieldarray['rdc_offset'] = 0;
        // append fields for LIMIT and OFFSET
        $col_count = count($GLOBALS['screen_structure']['main']['fields'])+1;
        $GLOBALS['screen_structure']['main']['fields'][$col_count][] = array('label' => 'rdc_limit',);
        $GLOBALS['screen_structure']['main']['fields'][$col_count][] = array('field' => 'rdc_limit');
        $GLOBALS['screen_structure']['main']['fields'][$col_count][] = array('label' => 'rdc_offset');
        $GLOBALS['screen_structure']['main']['fields'][$col_count][] = array('field' => 'rdc_offset');

        $this->rows_per_page = 0;

        $this->fieldspec  = $fieldspec;

        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_getColumnNames')) {
                $fieldarray = $this->custom_processing_object->_cm_getColumnNames($fieldarray);
            } // if
        } // if
        if ($this->errors) return;
        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            $fieldarray = $this->_cm_getColumnNames($fieldarray);
            if ($this->errors) return;
        } // if

        $this->fieldarray = $fieldarray;

        return $fieldarray;

    } // getColumnNames

    // ****************************************************************************
    function getCount ($where=null)
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
        $data_raw     = array();

//        if (!empty($this->sql_where)) {
//            // remove anything in $this->sql_where which is duplicated in $where
//            $this->sql_where = filterWhere1Where2($where, $this->sql_where, $this->tablename);
//        } // if

        $this->where = $where;      // save

        if (is_null($this->pageno)) {
            $this->pageno = 1;      //default
        } // if

        // convert $where from string to an associative array
        $where_array = where2array($where, $this->pageno);

        if (!empty($where_array['rdc_table_name'])) {
            $where_array = convert_parent_id_to_child_id($where_array, $this->tablename, $this->parent_relations);
            $where = array2where($where_array);
        } // if

        // make this data available if passed down by parent object
        if (empty($this->fieldarray)) {
            $fieldarray = array();
        } else {
            if (is_string(key($this->fieldarray))) {
                $fieldarray = $this->fieldarray;
            } else {
                $fieldarray = array_shift($this->fieldarray);
            } // if
        } // if

        if ($this->initiated_from_controller) {
            // replace with original unmodified version
            $this->sql_search = $this->sql_search_orig;
        } // if

        // perform any custom pre-retrieve processing
        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_pre_getData')) {
                $where = $this->custom_processing_object->_cm_pre_getData($where, $where_array, $fieldarray);
            } // if
        } // if
        if ($this->errors) return;
        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            $where = $this->_cm_pre_getData($where, $where_array, $fieldarray);
            if ($this->errors) return;
        } // if

        if ($this->where != $where) {
            // $where has been modified, so update $where_array
            $this->where = $where;
            $where_array = where2array($where, $this->pageno);
        } // if

        if ($this->checkPrimaryKey AND !$this->allow_empty_where) {
            // check that full primary key (or candidate key) has been supplied
            list($where1, $errors1) = isPkeyComplete($where_array, $this->getPkeyNames(), $this->unique_keys, $this);
            if (!empty($errors1)) {
                $this->errors = $errors1;
                return;
            } // if
            $this->checkPrimaryKey = false;
        } // if

        if ($this->skip_getdata) {
            // use data already loaded in
            if (is_int(key($this->fieldarray))) {
                // already indexed by row
                $data_raw = $this->fieldarray;
            } else {
                if (empty($this->fieldarray)) {
                    $data_raw = array();
                } else {
                    // associative array, so make it row zero
                    $data_raw[0] = $this->fieldarray;
                } // if
            } // if
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

            // get the data from the database
            $data_raw = $this->_dml_getData($where_str);
        } // if

        if (!empty($this->select_string)) {
            $data_raw = $this->setSelectedRows($this->select_string, $data_raw);
        } // if

        if ($this->initiated_from_controller) {
            if (isset($GLOBALS['script_vars']['task_id_run_at_end'])) {
                if ($this->rows_per_page > 1
                OR ($this->rows_per_page = 1 AND $this->numrows > 1)) {
                    // too many rows selected, so turn this option off
                    unset($GLOBALS['script_vars']['task_id_run_at_end']);
                    unset($GLOBALS['script_vars']['task_id_run_at_end_context']);
                } else {
                    // set context for this option
                    $GLOBALS['script_vars']['task_id_run_at_end_context'] = $where;
                } // if
            } // if
        } // if

        if ($GLOBALS['mode'] != 'insert') {
            // clear 'nodisplay' option which may have been by previous iteration
            foreach ($this->fieldspec as $field => $spec) {
                if (array_key_exists('autoinsert', $spec) or array_key_exists('autoupdate', $spec)) {
                    unset($this->fieldspec[$field]['nodisplay']);
                } // if
            } // foreach
        } // if

//        $entry = getEntryPoint($this);
//        if (strtolower($entry) == 'getdata') {
            if (isset($this->instruction)) {
                $data_raw = $this->_processInstruction($data_raw);
            } // if

            // perform any custom post-retrieve processing
            if (is_object($this->custom_processing_object)) {
                if (method_exists($this->custom_processing_object, '_cm_post_getData')) {
                    $data_raw = $this->custom_processing_object->_cm_post_getData($data_raw, $where);
                } // if
            } // if
            if ($this->custom_replaces_standard) {
                $this->custom_replaces_standard = false;
            } else {
                $data_raw = $this->_cm_post_getData($data_raw, $where);
            } // if
            $this->where = $where;
//        } // if

        // perform any formatting on the raw data
        $this->fieldarray = array();
        foreach ($data_raw as $rowdata) {
            $this->fieldarray[] = $rowdata;
        } // foreach

        return $this->fieldarray;

    } // getData

    // ****************************************************************************
    function getData_raw ($where=null)
    // get data from this table using optional 'where' criteria.
    // this is returned raw (as read from the database with any formatting).
    {
        $this->errors = array();

        // convert $where from string to an associative array
        $where_array = where2array($where);

        if (isset($this->fieldspec['rdcaccount_id'])) {
            // this table is split by account, so account_id must be supplied in WHERE string
            if (!isset($where_array['rdcaccount_id'])) {
                $account_id =& $_SESSION['rdcaccount_id'];
                if (empty($account_id) AND preg_match('/(mnu_user|mnu_account)/i', $this->tablename)) {
                    // no account id supplied, so read everything on these tables only
                } else {
                    if (empty($account_id) OR $account_id == 1) {
                        $account_id_string = "$this->tablename.rdcaccount_id='1'";
                    } else {
                        $account_id_string = "$this->tablename.rdcaccount_id IN ('1', '$account_id')";
                    } // if
                    if (empty($this->sql_where)) {
                        $this->sql_where = $account_id_string;
                    } else {
                        if (substr_count($this->sql_where, $account_id_string) == 0) {
                            $this->sql_where .= " AND $account_id_string";
                        } // if
                    } // if
                } // if
            } // if
        } // if

        if (!empty($this->sql_where)) {
            if (preg_match('/^(OR )/i', $this->sql_where)) {
                // begins with 'OR ', so do not append using ' AND '
                $where .= ' '.$this->sql_where;
            } else {
                if (empty($where)) {
                    $where = $this->sql_where;
                } else {
                    $where = "$where AND $this->sql_where";
                } // if
            } // if
        } // if

        if (!empty($this->sql_search)) {
            // turn 'current/historic/future' into a range of dates
            $this->sql_search = $this->currentOrHistoric($this->sql_search, $this->nameof_start_date, $this->nameof_end_date);
            if (!empty($this->sql_search)) {
                if (empty($where)) {
                    $where = $this->sql_search;
                } else {
                    $where = "$where AND $this->sql_search";
                } // if
            } // if
        } // if

//        if (!empty($this->sql_from)) {
//            $alias_array = extractAliasNames($this->sql_select);
//            // anything in WHERE which has an alias name will be moved to HAVING
//            $having_array = where2array($this->sql_having, false, false);
//            $where = qualifyWhere($where, $this->tablename, $this->fieldspec, $this->sql_from, $this->sql_search_table, $alias_array, $having_array);
//        } // if

        $data_raw = $this->_dml_getData($where, TRUE);

        return $data_raw;

    } // getData_raw

    // ****************************************************************************
    function getData_serial ($where=null, $rdc_limit=null, $rdc_offset=null, $unbuffered=false)
    // get data from this table using optional 'where' criteria.
    // this does not return the records one page at a time but allows a serial
    // read via the fetchRow() method of all records for processing in another way,
    // such as exporting to CSV.
    {
        $this->errors = array();    // initialise

        $this->where = $where;      // save

        // convert $where from string to an associative array
        $where_array = where2array($where, $this->pageno);

        if ($this->initiated_from_controller AND !empty($this->sql_search_orig)) {
            // replace with original unmodified version
            $this->sql_search = $this->sql_search_orig;
        } // if

        // perform any custom pre-retrieve processing
        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_pre_getData')) {
                $where = $this->custom_processing_object->_cm_pre_getData($where, $where_array, $this->fieldarray);
            } // if
        } // if
        if ($this->errors) return;
        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            $where = $this->_cm_pre_getData($where, $where_array);
            if ($this->errors) return;
        } // if

        if ($this->where != $where) {
            // $where has been modified, so update $where_array
            $this->where = $where;
            $where_array = where2array($where, $this->pageno);
        } // if

        if ($this->checkPrimaryKey) {
            // check that full primary key (or candidate key) has been supplied
            list($where1, $errors1) = isPkeyComplete($where_array, $this->getPkeyNames(), $this->unique_keys);
            if (!empty($errors1)) {
                $this->errors = $errors1;
                return;
            } // if
            $this->checkPrimaryKey = false;
        } // if

        if ($this->skip_getdata) {
            // do not populate $this->fieldarray from the database
            if (is_int(key($this->fieldarray))) {
                // already indexed by row
                $data_raw = $this->fieldarray;
            } else {
                // associative array, so make it row zero
                $data_raw[0] = $this->fieldarray;
            } // if
            $this->fieldarray = $data_raw;
            $this->numrows    = count($data_raw);
            $resource         = null;
        } else {
            // assemble the $where string from its component parts
            $where_str = $this->_sqlAssembleWhere($where, $where_array);

            // get the result from the database
            $resource = $this->_dml_getData_serial($where_str, $rdc_limit, $rdc_offset, $this->unbuffered_query);
        } // if

        // Note: individual records are obtained using the fetchRow() method

        return $resource;

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
        $errors = $this->errors;
        $this->errors = array();

        if (!is_array($errors)) {
            // convert string into an array
            $errors = (array)$errors;
        } // if

        return $errors;

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
    function getExtraData ($input, $where=null)
    // get additional data for this table, such as lookup lists.
    {
        //$this->errors = array();

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
            //$where = array2where($fieldarray[$key]);
        } // if

        if (is_True($this->no_foreign_data)) {
            // skip this next bit
        } else {
            // retrieve data from foreign (parent) tables for each row
            foreach ($fieldarray as $rownum => $rowdata) {
                $fieldarray[$rownum] = $this->getForeignData($rowdata);
            } // foreach
        } // if

        // perform custom processing (such as obtaining lookup lists) on FIRST record only
        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_getExtraData')) {
                $fieldarray[$key] = $this->custom_processing_object->_cm_getExtraData($where, $fieldarray[$key]);
            } // if
        } // if
        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            $fieldarray[$key] = $this->_cm_getExtraData($where, $fieldarray[$key]);
        } // if

        $fieldarray[$key] = array_change_key_case($fieldarray[$key], CASE_LOWER);

        // change current table configuration (optional)
        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_changeConfig')) {
                $fieldarray[$key] = $this->custom_processing_object->_cm_changeConfig($where, $fieldarray[$key]);
            } // if
        } // if
        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else{
            // change current table configuration (optional)
            $fieldarray[$key] = $this->_cm_changeConfig($where, $fieldarray[$key]);
        } // if

        $pattern_id = getPatternId();
        if (preg_match('/MULTI4/i', $pattern_id) AND !empty($this->initial_values)) {
            foreach ($fieldarray as $rownum => $rowdata) {
                // insert any initial values obtained from MNU_INITIAL_VALUE_ROLE/USER table
                foreach ($this->initial_values as $key1 => $value1) {
                    if (empty($rowdata[$key1])) {
                        // current value is empty, so overwrite with initial value
                        $rowdata[$key1] = $value1;
                    } // if
                } // foreach
                $fieldarray[$rownum] = $rowdata;
            } // foreach
        } // if

        // store updated $fieldarray within this object
        $this->fieldarray = $fieldarray;

        return $this->getFieldArray();

    } // getExtraData

    // ****************************************************************************
    function getFieldArray ()
    // return array of data that currently resides within this object
    // (usually stuff which was retrieved from the database).
    {
        if (empty($this->fieldarray)) {
            return array();
        } // if

        reset($this->fieldarray);
        if ($this->rows_per_page == 1) {
            // return an associative array (one row only)
            if (is_long(key($this->fieldarray))) {
                return $this->fieldarray[0];        // convert indexed to associative
            } else {
                return $this->fieldarray;
            } // if
        } else {
            // return an indexed array (one or more rows)
            if (is_long(key($this->fieldarray))) {
                return $this->fieldarray;
            } else {
                return array($this->fieldarray);    // convert associative to indexed
            } // if
        } // if

    } // getFieldArray

    // ****************************************************************************
    function getFieldSpec ()
    // return array of field specifications (which may be adjusted by $this->field_access).
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
        if (empty($this->fieldspec)) {
            // first time only - look for changes in engine, prefix or database name
            list($this->dbname, $this->dbprefix, $this->dbms_engine) = findDBConfig($this->dbname, $this->dbprefix, $this->dbms_engine);
        } // if

        if (is_bool($this->audit_logging) OR !empty($this->audit_logging)) {
            $save_audit_logging = $this->audit_logging;
        } else {
            $save_audit_logging = null;
        } // if

        $fieldspec                = array();
        $this->primary_key        = array();
        $this->unique_keys        = array();
        $this->child_relations    = array();
        $this->parent_relations   = array();
        $this->audit_logging      = FALSE;
        $this->default_orderby    = '';
        $this->alt_language_table = '';
        $this->alt_language_cols  = '';
        $this->nameof_start_date  = '';
        $this->nameof_end_date    = '';

        $tablename = $this->getTableName();
        if ($tablename != 'default') {
            // include table specifications generated by Data Dictionary
            if (!empty($this->dirname_dict)) {
                require ($this->dirname_dict .'/' .$tablename .'.dict.inc');
            } else {
                require ($this->dirname      .'/' .$tablename .'.dict.inc');
            } // if
            if (is_bool($save_audit_logging) OR !empty($save_audit_logging)) {
                $this->audit_logging = $save_audit_logging;
            } // if
        } // if

        if (defined('TRANSIX_NO_AUDIT') OR defined('NO_AUDIT_LOGGING')) {
            $this->audit_logging = false;
        } // if

        //if (empty($this->dbprefix)) {
        //    list($this->dbms_engine, $this->dbprefix, $this->dbname) = findDBPrefix($this->dbname);
        //} // if

        //if (empty($this->custom_processing_object)) {
        if ($this->dbname != 'default') {
            $this->_getCustomProcessingObject();
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

        // perform custom processing before standard processing
        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_getForeignData')) {
                $fieldarray = $this->custom_processing_object->_cm_getForeignData($fieldarray);
            } // if
        } // if
        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            $fieldarray = $this->_cm_getForeignData($fieldarray);
        } // if

        $fieldarray = array_change_key_case($fieldarray, CASE_LOWER);

        foreach ($this->parent_relations as $reldata) {
            if (isset($reldata['parent_field'])) {
                // may be more than one parent_field, so turn it into an array of separate field names
                list($parent_fields, $alias_array) = extractFieldNamesIndexed($reldata['parent_field']);
                $ix = 0;  // set to first entry
                if (!empty($fieldarray[$parent_fields[$ix]])) {
                    // parent field is already there, so do nothing
                } else {
                    // construct WHERE clause to read from parent table
                    $where_array = array();
                    foreach ($reldata['fields'] as $fldchild => $fldparent) {
                        if (strlen($fldchild) < 1) {
                            // 'Name of child field missing in relationship with $tblchild'
                            $this->errors[] = $this->getLanguageText('sys0110', strtoupper($tblchild));
                            break;
                        } // if
                        if (!isset($fieldarray[$fldchild]) or strlen($fieldarray[$fldchild]) == 0) {
                            // foreign key field is missing, so stop further processing
                            $where_array = array();
                            break;
                        } // if
                        if (preg_match('/^(IS NULL|IS NOT NULL)$/i', trim($fieldarray[$fldchild]))) {
                            if ($GLOBALS['mode'] != 'search') {
                                // does not contain a proper value, so do not attempt to read
                                $fieldarray[$fldchild] = null;
                            } // if
                            $where_array = array();
                            break;
                        } // if
                        $where_array[$fldparent] = $fieldarray[$fldchild];
                    } // foreach
                    if (empty($where_array)) {
                        // $where is empty, so set foreign field(s) to empty
                        foreach ($parent_fields as $ix => $parent_field) {
                            if (!isset($this->fieldspec[$parent_field])) {
                                // field is not is current $fieldspec array, so it can be initialised
                                $fieldarray[$parent_field] = null;
                            } // if
                        } // foreach
                    } else {
                        $where = array2where($where_array, false, false, true);
                        $tblparent = $reldata['parent'];
                        // instantiate an object for this table
                        if (array_key_exists('subsys_dir', $reldata)) {
                            $save_cwd = getcwd();
                            // switch to other directory so that any includes() within the class
                            // are relative to that directory and not the current directory
                            $dir = dirname($this->dirname);                          // path to current subsystem directory
                            $dir = dirname($dir) .'/' .$reldata['subsys_dir'] .'/';  // switch to other subsystem directory
                            chdir($dir);
                        } else {
                            $save_cwd = NULL;
                        } // if
                        if (!class_exists($tblparent)) {
                            require_once "classes/$tblparent.class.inc";
                        } // end
                        $parentobj = new $tblparent;
                        $parentobj->sql_select = $reldata['parent_field'];
                        $parent_data = $parentobj->getData($where);
                        unset($parentobj);
                        if (!empty($parent_data)) {
                            // copy specified parent field(s) into $fieldarray
                            foreach ($parent_fields as $ix => $parent_field) {
                                if (empty($fieldarray[$parent_field])) {
                                    // field is currently empty, so replace it with parent value
                                    if (array_key_exists($parent_field, $parent_data[0])) {
                                        $fieldarray[$parent_field] = $parent_data[0][$parent_field];
                                    } else {
                                        // original name not found, so look for an alias
                                        list($original, $alias) = getFieldAlias3($alias_array[$ix]);
                                        if ($original != $alias) {
                                            $fieldarray[$parent_field] = $parent_data[0][$original];
                                        } // if
                                    } // if
                                } // if
                            } // foreach
                        } else {
                            if ($GLOBALS['mode'] == 'search') {
                                // key may be incomplete, so leave it alone
                            } else {
                                // not found, so set foreign key(s) to empty
                                //foreach ($reldata['fields'] as $fldchild => $fldparent) {
                                //    if (in_array($fldchild, $this->primary_key)) {
                                //        // part of primary key, so leave it alone
                                //    } else {
                                //        // not part of primary key, so empty it
                                //        $fieldarray[$fldchild] = null;
                                //    } // f
                                //} // foreach
                            } // if
                        } // if
                        if (!empty($save_cwd)) {
                            // switch back to the original working directory
                            chdir($save_cwd);
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
                foreach ($fieldarray as $fieldname => $fieldvalue) {
                    if (!is_string($fieldname)) {
                        // this is a numeric index, not a valid field name, so remove it
                        unset($fieldarray[$fieldname]);
                    } else {
                        if (preg_match('/^(IS NULL|IS NOT NULL|NOT IN|IN[ ]?\()/i', trim($fieldvalue))) {
                            // not a valid value, so remove it
                            unset($fieldarray[$fieldname]);
                        } elseif (array_key_exists($fieldname, $this->fieldspec)) {
                            if (!empty($fieldvalue)) {
                                // do not allow any items in $where criteria to be changed
                                $this->fieldspec[$fieldname]['noedit'] = 'y';
                            } // if
                        } // if
                    } // if
                } // foreach
            } // if
        } else {
            $fieldarray = array();
        } // if

        if (!empty($this->initial_values)) {
            // insert any initial values obtained from MNU_INITIAL_VALUE_ROLE/USER table
            foreach ($this->initial_values as $key => $value) {
                if (empty($fieldarray[$key])) {
                    // current value is empty, so overwrite with initial value
                    $fieldarray[$key] = $value;
                } // if
            } // foreach
        } // if

        // perform any custom processing (optional)
        $this->sqlSelectInit();
        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_getInitialData')) {
                $fieldarray = $this->custom_processing_object->_cm_getInitialData($fieldarray);
            } // if
        } // if
        if ($this->errors) return $fieldarray;
        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            $fieldarray = $this->_cm_getInitialData($fieldarray);
        } // if
        if ($this->errors) return $fieldarray;

        $fieldarray = array_change_key_case($fieldarray, CASE_LOWER);

        if (isset($this->fieldspec['rdcaccount_id'])) {
            if (empty($_SESSION['rdcaccount_id'])) {
                if (preg_match('/(mnu_user|mnu_account)/i', $this->tablename)) {
                    // do nothing on this table
                } else {
                    // use the 'sharing' id
                    $fieldarray['rdcaccount_id'] = 1;
                } // if
            } else {
                // always use this user's account_id
                $fieldarray['rdcaccount_id'] = $_SESSION['rdcaccount_id'];
            } // if
        } // if

        // do not display autoinsert/autoupdate fields on input screens
        foreach ($this->fieldspec as $field => $spec) {
            if (array_key_exists('auto_increment', $spec) OR array_key_exists('autoinsert', $spec) OR array_key_exists('autoupdate', $spec)) {
                $this->fieldspec[$field]['nodisplay'] = 'y';
            } // if
        } // foreach

        reset($fieldarray);  // fix to enable key($fieldarray) to work
        if (!empty($fieldarray) and !is_string(key($fieldarray))) {
            // this has multiple rows, so ignore
        } else {
            // shift all field names to lower case
            $fieldarray = array_change_key_case($fieldarray, CASE_LOWER);
            if (is_True($this->ignore_empty_fields)) {
                // do not insert any missing fields
                $this->ignore_empty_fields = false;
            } else {
                // insert values for any missing fields
                foreach ($this->fieldspec as $fieldname => $spec) {
                    if (isset($spec['nondb'])) {
                        // this is a non-database field, so ignore it
                    } else {
                        if (strlen($fieldarray[$fieldname]) < 1) {
                            if (strlen($spec['default']) > 0 AND !preg_match('/(date|time|datetime)/i', $spec['type'])) {
                                if (array_key_exists('autoinsert', $spec) OR array_key_exists('autoupdate', $spec) OR $fieldname == 'rdcaccount_id') {
                                    // value will be inserted later
                                    $fieldarray[$fieldname] = NULL;
                                } else {
                                    // default value exists, so load it
                                    $fieldarray[$fieldname] = $spec['default'];
                                } // if
                            } else {
                                // load an empty value so the field will appear in the XML output
                                $fieldarray[$fieldname] = NULL;
                            } // if
                        } // if
                    } // if
                } // foreach
            } // if
        } // if

        $this->fieldarray = $fieldarray;

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
                // convert 'where' string to an array which is indexed by row number
                $array1 = splitWhereByRow($where);
                // convert 'where' for each row into an associative array
                foreach ($array1 as $rownum => $rowdata) {
                    $fieldarray[] = where2array($rowdata);
                } // foreach
            } // if
        } else {
            $fieldarray = array();
        } // if

        // perform any custom processing (optional)
        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_getInitialDataMultiple')) {
                $fieldarray = $this->custom_processing_object->_cm_getInitialDataMultiple($fieldarray);
            } // if
        } // if
        if ($this->errors) return $fieldarray;

        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            // perform any custom processing (optional)
            $fieldarray = $this->_cm_getInitialDataMultiple($fieldarray);
        } // if
        if ($this->errors) return $fieldarray;

        $fieldarray = array_change_key_case($fieldarray, CASE_LOWER);

        $this->fieldarray = $fieldarray;

        return $fieldarray;

    } // getInitialDataMultiple

    // ****************************************************************************
    function getInstruction ()
    // return an optional instruction to the previous script.
    {
        return $this->instruction;

    } // getInstruction

    // ****************************************************************************
    function getLanguageArray ($id)
    // get named array from the language file.
    {
        $classdir = $GLOBALS['classdir'];  // save
        $cwd      = getcwd();
        if (!empty($this->dirname) AND $cwd != dirname($this->dirname)) {
            // switch to correct directory for retrieving message text
            $GLOBALS['classdir'] = dirname($this->dirname);
            chdir($GLOBALS['classdir']);
        } // if

        // call the function in the standard library
        $string = getLanguageArray ($id);

        $GLOBALS['classdir'] = $classdir;  // restore
        chdir($cwd);

        return $string;

    } // getLanguageArray

    // ****************************************************************************
    function getLanguageEntries ($rows, $parent_data, $fieldlist)
    // ensure that $rows contains an entry for each supported language on MNU_LANGUAGE.
    {
        if (!empty($rows)) {
            return $rows;  // some records already there, so do nothing
        } // if

        // convert $fieldlist from string to array
        $fieldlist = explode(',', $fieldlist);

        // edit data passed down from parent record
        foreach ($parent_data as $fieldname => $fieldvalue) {
            // remove unwanted columns
            if (!array_key_exists($fieldname, $this->fieldspec)) {
                // field does not exist in this table, so remove it
                unset($parent_data[$fieldname]);
            } elseif (array_key_exists('pkey', $this->fieldspec[$fieldname])) {
                // leave the primary key
            } elseif ($this->fieldspec[$fieldname]['type'] != 'string') {
                // not a string field, so remove it
                unset($parent_data[$fieldname]);
            } elseif (array_key_exists('autoinsert', $this->fieldspec[$fieldname])) {
                unset($parent_data[$fieldname]);
            } elseif (array_key_exists('autoupdate', $this->fieldspec[$fieldname])) {
                unset($parent_data[$fieldname]);
            } // if
        } // foreach

        $where = array2where($parent_data, $this->getPkeyNames(), $this);

        // obtain list of supported languages
        $language_array = $_SESSION['supported_languages'];
        if (!empty($_SESSION['default_language'])) {
            // remove default language as this is not an alternative
            unset($language_array[$_SESSION['default_language']]);
        } // if

        // eliminate languages which already have an entry on this table
        foreach ($rows as $rownum => $rowdata) {
            if (array_key_exists($rowdata['language_id'], $language_array)) {
                unset($language_array[$rowdata['language_id']]);
            } // if
        } // foreach

        // create entries for languages which are missing
        foreach ($language_array as $language_id => $language_code) {
            $fieldarray = $parent_data;
            $fieldarray['language_id'] = $language_id;
            //$new_data[] = $fieldarray;
            $newdata = $this->insertOrUpdate($fieldarray);
            if ($this->errors) {
                $result = $this->rollback();
                return false;
            } // if
            $rows[] = $newdata;
        } // foreach

        return $rows;

    } // getLanguageEntries

    // ****************************************************************************
    function getLanguageText ($id, $arg1=null, $arg2=null, $arg3=null, $arg4=null, $arg5=null)
    // get text from the language file and include up to 5 arguments.
    {
        $classdir = $GLOBALS['classdir'];  // save
        $cwd      = getcwd();
        if (!empty($this->dirname) AND $cwd != dirname($this->dirname)) {
            // switch to correct directory for retrieving message text
            $GLOBALS['classdir'] = dirname($this->dirname);
            chdir($GLOBALS['classdir']);
        } // if

        // call the function in the standard library
        $string = getLanguageText ($id, $arg1, $arg2, $arg3, $arg4, $arg5);

        $GLOBALS['classdir'] = $classdir;  // restore
        chdir($cwd);

        return $string;

    } // getLanguageText

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
            $data = $this->lookup_data;
        } else {
            $data = array();
        } // if

        if (!empty($this->lookup_css)) {
            $css = $this->lookup_css;
        } else {
            $css = array();
        } // if

        return array($data, $css);

    } // getLookupData

    // ****************************************************************************
    function getMessages ()
    // return any messages which are not errors.
    {
        $messages = (array)$this->messages;

        $this->messages = array();

        return $messages;

    } // getMessages

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
    // return current sort order (to be used in sql SELECT statement).
    {
        // allow sort order to be customised
        $orderby = $this->_cm_getOrderBy($this->sql_orderby);

        if (empty($orderby)) {
            $orderby = $this->default_orderby_task;
        } // if
        if (empty($orderby)) {
            $orderby = $this->default_orderby;
        } // if

        if (empty($orderby)) {
            $this->sql_orderby_seq = null;
        } else {
            if (!empty($this->sql_from)) {
                $orderby = qualifyOrderby($orderby, $this->tablename, $this->fieldspec, $this->sql_select, $this->sql_from);
            } // if
            $this->sql_orderby_seq = $this->getOrderBySeq($orderby, $this->sql_orderby_seq);
        } // if

        return $orderby;

    } // getOrderBy

    // ****************************************************************************
    function getOrderBySeq (&$orderby=null, $orderby_seq=null)
    // return sort sequence ('asc' or 'desc').
    // NOTE: $orderby is passed by reference as it may be modified
    {
        if (empty($orderby)) {
            $orderby_seq = null;
        } else {
            // find out if any sort sequence has been specified on any first field
            $array = explode(',', $orderby);
            // look for any trailing 'asc' or 'desc'
            $pattern = '/( asc| ascending| desc| descending)$/i';
            $found = false;
            foreach ($array as $sortfield) {
                if (preg_match($pattern, $sortfield, $regs)) {
                    $found = true;
                    if (count($array) == 1) {
                        // only one field, so remove sequence from fieldname
                        $orderby = substr($orderby, 0, -strlen($regs[0]));
                        $orderby_seq = trim($regs[0]);
                    } else {
                        // more than one field, so remove separate sequence
                        $orderby_seq = null;
                    } // if
                } // if
            } // foreach
            if ($found == false AND empty($orderby_seq)) {
                $orderby_seq = 'asc';
            } // if
        } // if

        return $orderby_seq;

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
    function &getParentData ()
    // return $fieldarray from the parent object.
    // NOTE: output is passed by reference.
    {
        if (!is_object($this->parent_object)) {
            return FALSE;
        } elseif (!method_exists($this->parent_object, 'getFieldArray')) {
            return FALSE;
        } // if

        $parent_data =& $this->parent_object->getFieldArray();

        return $parent_data;

    } // getParentData

    // ****************************************************************************
    function getPkeyArray ($fieldarray=null, $next_task=null)
    // return the list of primary key values for the last selection of data
    // which was retrieved from this table (or the passed array).
    {
        // get name(s) of field(s) which form the primary key
        $pkeynames = $this->getPkeyNames();

        if (!empty($next_task) AND !preg_match('/^(audit)/i', $next_task['task_id'])) {
            // obtain any custom adjustments to this array
            $task_id    = $next_task['task_id'];
            $pattern_id = $next_task['pattern_id'];
            $pkeynames  = $this->_cm_getPkeyNames($pkeynames, $task_id, $pattern_id);
        } // if

        if (empty($fieldarray)) {
            $fieldarray = $this->fieldarray;
        } // if

        reset($fieldarray);   // fix for version 4.4.1
        if (!is_array($fieldarray[key($fieldarray)])) {
            // array is one level deep - convert to 2 levels
            $fieldarray = array($fieldarray);
        } // if

        $pkeyarray = array();
        $rowcount  = 0;

        // step through each row
        foreach ($fieldarray as $row) {
            // note that $rowcount starts at 1, not 0
            $rowcount++;
            foreach ($pkeynames as $fieldname) {
                // add 'name=value' to array
                $pkeyarray[$rowcount][$fieldname] =& $row[$fieldname];
                if ($fieldname == 'id') {
                    // include name of this table so that 'id' can be translated in the child
                    $pkeyarray[$rowcount]['rdc_table_name'] = get_class($this);
                } // if
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
    function getPkeyNamesAdjusted ()
    // return the (adjusted) list of primary key fields in this table.
    {
        // get array of original names
        $pkey_names  = $this->getPkeyNames();

        // allow this array to be adjusted
        $task_id    = $_SESSION['pages'][getSelf()]['task_id'];
        $pattern_id = getPatternId();

        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_getPkeyNames')) {
                $pkey_names = $this->custom_processing_object->_cm_getPkeyNames($pkey_names, $task_id, $pattern_id);
            } // if
        } // if

        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            $pkey_names = $this->_cm_getPkeyNames($pkey_names, $task_id, $pattern_id);
        } // if

        return $pkey_names;

    } // getPkeyNamesAdjusted

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
            if (!function_exists('findJump')) {
                require_once 'include.jump.inc';
            } // if
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
        $search = mergeWhere($this->sql_where, $this->sql_search_orig);

        return $search;

    } // getSearch

    // ****************************************************************************
    function getTableName ()
    // return the name of this table.
    {
        return strtolower($this->tablename);

    } // getTableName

    // ****************************************************************************
    function getValRep ($item, $where=null, $orderby=null)
    // get Value/Representation list from this table.
    {
        $item = strtolower($item);

        // call custom method to obtain data as an associative array.
        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_getValRep')) {
                $array = $this->custom_processing_object->_cm_getValRep($item, $where, $orderby);
            } // if
        } // if

        if (empty($array)) {
            $array = $this->_cm_getValRep($item, $where, $orderby);
        } // if

        return $array;

    } // getValRep

    // ****************************************************************************
    function getWhere ($next_task)
    // return current selection criteria (may have been amended) before it is
    // passed to the next task.
    {
        $where = mergeWhere($this->where, $this->sql_where);

        $array1 = splitWhereByRow($where);
        if (count($array1) > 1 AND $this->rows_per_page == 1) {
            // multiple rows selected, but only one row displayed, so ...
            // reduce WHERE to current row only
            $where = array2where($this->fieldarray, $this->getPkeyNamesAdjusted());
        } // if

        if (!empty($where)) {
            $pkeynames = $this->getPkeyNames();
            if (count($pkeynames) == 1) {
                if ($pkeynames[0] == 'id') {
                    $where .= " AND rdc_table_name='".get_class($this)."'";
                } // if
            } // if
        } // if

        if (!empty($next_task) AND !preg_match('/^(audit)/i', $next_task['task_id'])) {
            // obtain any custom adjustments to this string
            $task_id    = $next_task['task_id'];
            $pattern_id = $next_task['pattern_id'];
            if (is_object($this->custom_processing_object)) {
                if (method_exists($this->custom_processing_object, '_cm_getWhere')) {
                    $where = $this->custom_processing_object->_cm_getWhere($where, $task_id, $pattern_id);
                } // if
            } // if
            if ($this->custom_replaces_standard) {
                $this->custom_replaces_standard = false;
            } else {
                $where = $this->_cm_getWhere($where, $task_id, $pattern_id);
            } // if
        } // if

        return $where;

    } // getWhere

    // ****************************************************************************
    function initialise ($where=null, &$selection=null, $search=null)
    // perform any initialisation for the current task.
    // Note that $selection is PASSED BY REFERENCE as it may be updated.
    {
        $this->pageno = null;
        $this->where  = null;

        $pattern_id = getPatternId();

        if (isset($GLOBALS['settings'])) {
            if (is_string($GLOBALS['settings'])) {
                parse_str($GLOBALS['settings'], $GLOBALS['settings']);
            } // if
            if (array_key_exists('allow_empty_where', $GLOBALS['settings'])) {
                $this->allow_empty_where = TRUE;
            } // if
        } // if

//        if (empty($this->custom_processing_object)) {
            $this->_getCustomProcessingObject();
//        } // if

        if (preg_match('/^(mnu_initial_value_)/i', $this->tablename)) {
            // do not look for initial values for the initial values tables
        } else {
            if ($this->initiated_from_controller) {
                // obtain any initial values from MNU_INITIAL_VALUE_ROLE/USER table
                $this->initial_values = $this->_getInitialValues();

                if (preg_match('/^(list|output)/i', $pattern_id)) {
                    $this->sql_where = $this->_getInitialWhere($this->sql_where);
                } // if
            } // if
        } // if

        if (preg_match('/^(add|upd2)/i', $pattern_id)) {
            // do not swap $selection with $where
        } else {
            if (empty($where) AND !empty($selection)) {
                // $where is empty, so use $selection instead
                $where     = $selection;
                $selection = null;
            } // if
        } // if

        if (!empty($this->sql_where)) {
            // extra WHERE provided in component script
            if (empty($where)) {
                $where = $this->sql_where;
            } else {
                //$where .= ' AND ' .$this->sql_where;
                $where = mergeWhere($where, $this->sql_where);
            } // if
            //$this->sql_where = null;
        } // if

        $where2 = $where;  // save for comparison

        // perform any custom initialisation (optional)
        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_initialise')) {
                $where2 = $this->custom_processing_object->_cm_initialise($where2, $selection, $search);
            } // if
        } // if
        if ($this->errors) return $where2;
        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            $where2 = $this->_cm_initialise($where2, $selection, $search);
        } // if
        if ($this->errors) return $where2;

        if ($where2 != $where) {
            // this was changed in _cm_initialise(), so use the new version
            $where = $where2;
        } else {
            if (preg_match('/^(add|upd2)/i', $pattern_id)) {
                // do not swap $selection with $where
            } else {
                if (!empty($selection)) {
                    // $selection takes precedence over $where
                    $where     = $selection;
                    $selection = null;
                } // if
            } // if
        } // if

        // convert $where string to an array
        $fieldarray  = where2array($where, false, false);

        if (isset($this->fieldspec['rdcaccount_id'])) {
            // is this field editable or non-editable?
            if (isset($_SESSION['rdcaccount_id']) AND $_SESSION['rdcaccount_id'] > 1) {
                $this->fieldspec['rdcaccount_id']['noedit'] = 'y';
            } else{
                if ($this->tablename == 'mnu_user') {
                    unset($this->fieldspec['rdcaccount_id']['noedit']);
                    unset($this->fieldspec['rdcaccount_id']['nodisplay']);
                } else {
                    $this->fieldspec['rdcaccount_id']['noedit'] = 'y';
                } // if
            } // if
            if (count($fieldarray) == 1) {
                $fieldarray = unqualifyFieldArray($fieldarray);
                if (isset($fieldarray['rdcaccount_id'])) {
                    // 'rdcaccount_id' is the only value, so can we remove it?
                    if ($this->tablename == 'mnu_account') {
                        // this is allowed on this table
                    } else {
                        $where = null;
                        $fieldarray = array();
                    } // if
                } // if
            } // if
        } // if

        if (!empty($this->alt_language_table)) {
            if ($GLOBALS['mode'] == 'update') {
                if ($_SESSION['user_language'] != $_SESSION['default_language']) {
                    if (!empty($this->alt_language_cols)) {
                        // cannot update text in base table which was obtained from alternative language table
                        $fieldnames = explode(', ', $this->alt_language_cols);
                        foreach ($fieldnames as $fieldname) {
                            $this->fieldspec[$fieldname]['noedit'] = 'y';
                        } // foreach
                        $this->messages[] = $this->getLanguageText('sys0180');
                    } // if
                } // if
            } // if
        } // if

        $fieldarray2 = $fieldarray;  // save for later comparison

        // change current table configuration (optional)
        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_changeConfig')) {
                $fieldarray2 = $this->custom_processing_object->_cm_changeConfig($where, $fieldarray2);
            } // if
        } // if
        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            $fieldarray2 = $this->_cm_changeConfig($where, $fieldarray2);
        } // if

        if ($fieldarray2 != $fieldarray) {
            $where = array2where($fieldarray2, $this->fieldspec);
        } // if

        if (!empty($this->where)) {
            // replace with string saved in _cm_initialise()
            $where = $this->where;
        } else {
            if (!empty($where)) {
                // remove any fields which do not exist in current table to avoid an SQL error
                $extra = array();
                if (is_object($this->custom_processing_object)) {
                    if (method_exists($this->custom_processing_object, '_cm_filterWhere')) {
                        $extra = $this->custom_processing_object->_cm_filterWhere($extra);
                    } // if
                } // if
                if ($this->custom_replaces_standard) {
                    $this->custom_replaces_standard = false;
                } else {
                    $extra = $this->_cm_filterWhere($extra);
                } // if
                $where = filterWhere($where, $this->fieldspec, $this->tablename, $extra, $this);
            } // if
        } // if
        $this->where = $where;

        if ($this->initiated_from_controller == true AND $GLOBALS['mode'] == 'search') {
            // rebuild array to include '=' and 'LIKE' operators
            $fieldarray = where2array($where, false, false);
            // do not allow any $where criteria to be changed
            foreach ($fieldarray as $fieldname => $fieldvalue) {
                if (is_integer($fieldname)) {
                    // this is an index to a string such as 'EXISTS (...)', so delete it
                    unset($fieldarray[$fieldname]);
                } elseif (!empty($fieldvalue)) {
                    if (preg_match('/^(LIKE )/i', ltrim($fieldvalue))) {
                        // ignore values starting with 'LIKE ' as they come from previous search
                    } elseif (preg_match('/^(IS NULL|IS NOT NULL|NOT IN|IN[ ]?\(|NOT LIKE)/i', trim($fieldvalue))) {
                        // not a valid value, so remove it
                        unset($fieldarray[$fieldname]);
                    } else {
                        if (array_key_exists('control', $this->fieldspec[$fieldname])) {
                            // if 'control' is set then only operators of '=' are allowed
                            if (preg_match('/^=/', trim($fieldvalue))) {
                                $fieldarray[$fieldname] = stripOperators($fieldvalue);
                                $this->fieldspec[$fieldname]['noedit'] = 'y';
                            } else {
                                unset($fieldarray[$fieldname]);
                            } // if
                        } elseif (preg_match('/^=/', trim($fieldvalue))) {
                            $fieldarray[$fieldname] = stripOperators($fieldvalue);
                            $this->fieldspec[$fieldname]['noedit'] = 'y';
                        } else {
                            $this->fieldspec[$fieldname]['noedit'] = 'y';
                            if (preg_match('/^(null)$/i', $fieldvalue)) {
                                // replace 'null' (the string) with NULL (the value)
                                $fieldarray[$fieldname] = null;
                            } // if
                        } // if
                    } // if
                } // if
            } // foreach

            foreach ($this->fieldspec as $fieldname => $fieldspec) {
                // do not display any fields marked with 'nosearch'
                if (isset($fieldspec['nosearch'])) {
                    $this->fieldspec[$fieldname]['nodisplay'] = 'y';
                } // if
                // remove 'required' property to make all fields optional
                if (isset($fieldspec['required'])) {
                    unset($this->fieldspec[$fieldname]['required']);
                } // if
            } // foreach

            // look for start_date and end_date in $fieldspec
            if (!empty($this->nameof_start_date)) {
                $start_date = $this->nameof_start_date;
            } else {
                $start_date = 'start_date';
            } // if
            if (!empty($this->nameof_end_date)) {
                $end_date = $this->nameof_end_date;
            } else {
                $end_date = 'end_date';
            } // if
            if (isset($this->fieldspec[$start_date]) AND isset($this->fieldspec[$end_date])) {
                $this->setCurrentOrHistoric();
            } // if

            if (!empty($this->sql_search_table)) {
                $search_table = $this->sql_search_table;
            } else {
                $search_table = $this->tablename;
            } // if

            if (is_array($_SESSION['search']) AND isset($_SESSION['search'][$search_table])) {
                // retrieve previous search criteria and copy into this screen
                $previous = $_SESSION['search'][$search_table];
                // convert from string to associative array
                $previous = where2array($previous, false, false);
                // remove any field that does not belong in this table
                foreach ($previous as $field => $value) {
                    list($operator, $value, $delimiter) = extractOperatorValue($value);
                    $value = stripslashes($value);
                    if (!array_key_exists($field, $this->fieldspec)) {
                        // this field doesn't exist in current table, so remove the value
                        unset($previous[$field]);
                    } else {
                        if (strlen($value) > 1 AND substr_count($value, '%') == 1) {
                            // remove trailing '%'
                            $value = rtrim($value, '%');
                        } // if
                    } // if
                    // if field is aready in $fieldarray do NOT overwrite it
                    if (array_key_exists($field, $fieldarray)) {
                        unset($previous[$field]);
                    } else {
                        if (preg_match('/(=|LIKE)/i', $operator)) {
                            $previous[$field] = $value;
                        } elseif (preg_match('/^[a-zA-Z]+/', $operator)) {
                            // operator is alphabetic, so insert a space between it and the value
                            $previous[$field] = $operator.' '.$value;
                        } else {
                            $previous[$field] = $operator.$value;
                        } // if
                    } // if
                } // foreach
                // merge data into a single array
                $fieldarray = array_merge($previous, $fieldarray);
            } // if

            if (isset($this->fieldspec['curr_or_hist'])) {
                if (empty($fieldarray['curr_or_hist'])) {
                    // field is defined but no value is available, so set it to the default
                    $fieldarray['curr_or_hist'] = 'C';
                } // if
            } // if

            // save, then convert back into string
            $this->fieldarray = $fieldarray;
            $where = array2where($fieldarray);

        } // if

        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_setJavaScript')) {
                $this->javascript = $this->custom_processing_object->_cm_setJavaScript($this->javascript);
            } // if
        } // if
        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            $this->javascript = $this->_cm_setJavaScript($this->javascript);
        } // if

        if (isset($GLOBALS['mode']) AND preg_match('/(search|list|read)/i', $GLOBALS['mode'])) {
            // ignore this next bit
        } else {
            if ($this->initiated_from_controller) {
                if (preg_match('/^(workflow|audit)$/i', $this->dbname) OR defined('TRANSIX_NO_WORKFLOW') OR defined('RADICORE_NO_WORKFLOW')) {
                    // do nothing
                } else {
                    if (is_string($where) AND !empty($where)) {
                        // find out if this task/context is a workitem within a workflow instance
                        $this->_examineWorkflowInstance($where);
                    } // if
                } // if
            } // if
        } // if

        return $where;

    } // initialise

    // ****************************************************************************
    function initialiseFileDownload ($where)
    // perform any initialisation for the file download operation.
    {
        if ($this->skip_getdata) {
            // do not read database, use $where string instead
            if (!empty($where)) {
                $fieldarray = where2array($where);
                $this->numrows = 1;
            } // if
        } else {
            $fieldarray = $this->getData_raw($where);

            if ($this->numrows < 1) {
                $this->errors[] = $this->getLanguageText('sys0085'); // 'Nothing retrieved from the database.'
                return false;
            } // if

            // change from indexed to associative for first row
            $fieldarray = $fieldarray[0];
        } // if

        $this->download_filename = 'download_filename';
        $this->download_mode     = '';  // 'inline' will disable option to save

        // call customisable method in the subclass.
        $fieldarray = $this->_cm_initialiseFileDownload($fieldarray);
        if (!empty($this->errors)) {
            return FALSE;
        } // if

        if (!isset($fieldarray['ignore_errors'])) {
            if (!file_exists($this->download_filename) ) {
                // 'file does not exist'
                $this->errors[] = $this->getLanguageText('sys0057', $this->download_filename);
            } // if
        } // if

        return $fieldarray;

    } // initialiseFileDownload

    // ****************************************************************************
    function initialiseFilePicker ($where, $search=null)
    // perform any initialisation for the filepicker operation.
    {
        $fieldarray = where2array($where);

        if (empty($this->picker_subdir)) {
            $this->picker_subdir  = 'picker';
        } // if
        $this->picker_filetypes   = array();

        $this->where      = $where;
        $this->fieldarray = $fieldarray;

        // call customisable method in the subclass.
        $fieldarray = $this->_cm_initialiseFilePicker($fieldarray, $search);
        if (!empty($this->errors)) {
            return FALSE;
        } // if

        if (is_array($fieldarray)) {
            $this->fieldarray = $fieldarray;
        } // if

        if (!isset($fieldarray['ignore_errors'])) {
            if (!is_dir($this->picker_subdir) ) {
                if (!is_dir(dirname($this->picker_subdir)) ) {
                    // 'source directory does not exist'
                    $this->errors[] = $this->getLanguageText('sys0059', $this->picker_subdir);
                } // if
            } // if
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
        if (empty($string)) {
            // default is any file extension
            $string = '^([^\.])'               // begins with anything but '.'
                    . '.*'                     // any number of characters
                    . '(\.[a-zA-Z0-9]+)$';     // ends with '.<anything>'
        } else {
            $string .= ')$';
        } // f

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
        $this->upload_maxfilesize = 1000000;

        // call customisable method in the subclass.
        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_initialiseFileUpload')) {
                $fieldarray = $this->custom_processing_object->_cm_initialiseFileUpload($fieldarray);
                $this->resize_array       = $this->custom_processing_object->resize_array;
                $this->upload_subdir      = $this->custom_processing_object->upload_subdir;
                $this->upload_filetypes   = $this->custom_processing_object->upload_filetypes;
                $this->upload_maxfilesize = $this->custom_processing_object->upload_maxfilesize;
            } // if
        } // if
        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            $fieldarray = $this->_cm_initialiseFileUpload($fieldarray);
        } // if
        if (!empty($this->errors)) {
            return FALSE;
        } // if

        $this->where = array2where($fieldarray);

        if (!is_dir($this->upload_subdir) ) {
            // 'destination directory does not exist'
            $this->errors[] = $this->getLanguageText('sys0123', $this->upload_subdir);
        } // if

        return $this->where;

    } // initialiseFileUpload

    // ****************************************************************************
    function insertMultiple ($fieldarray)
    // insert multiple records using data in $fieldarray.
    {
        $this->errors = array();
        $errors       = array();
        $this->no_display_count = false;
        $count                  = 0;

        reset($fieldarray);   // fix for version 4.4.1
        if (is_string(key($fieldarray))) {
            // array is NOT indexed by row, so adjust it
            $fieldarray = array($fieldarray);
        } // if

        // turn off feature in getInitialData() method
        $this->ignore_empty_fields = true;

        if (empty($this->errors)) {
            // perform any additional custom pre-processing
            if (is_object($this->custom_processing_object)) {
                if (method_exists($this->custom_processing_object, '_cm_pre_insertMultiple')) {
                    $fieldarray = $this->custom_processing_object->_cm_pre_insertMultiple($fieldarray);
                } // if
            } // if
            if ($this->custom_replaces_standard) {
                $this->custom_replaces_standard = false;
            } else {
                $fieldarray = $this->_cm_pre_insertMultiple($fieldarray);
            } // if
        } // if

        if (!$this->errors) {
            // insert each row one by one
            foreach ($fieldarray as $rownum => $data) {
                if (!empty($data)) {
                    $this->numrows = 0;
                    $fieldarray[$rownum] = $this->insertRecord($fieldarray[$rownum]);
                    if (!empty($this->errors)) {
                        // keep $errors separate for each row
                        $errors[$rownum] = $this->errors;
                    } else {
                        $count = $count + $this->numrows;
//                        if ($GLOBALS['mode'] == 'batch') {
//                            if ($count % 100 == 0) {
//                                echo "<p>$count records written</p>\n";
//                            } // if
//                        } // if
                    } // if
                } // if
            } // foreach

            $this->errors  = $errors;
            $this->numrows = $count;

            if (is_True($this->no_display_count)) {
                // do not display record count
            } else {
                // 'X records were inserted into tablename'
                $this->messages[] = $this->getLanguageText('sys0005', $count, strtoupper($this->tablename));
            } // if

            if (empty($this->errors)) {
                // perform any additional custom post-processing
                if (is_object($this->custom_processing_object)) {
                    if (method_exists($this->custom_processing_object, '_cm_post_insertMultiple')) {
                        $fieldarray = $this->custom_processing_object->_cm_post_insertMultiple($fieldarray);
                    } // if
                } // if
                if ($this->custom_replaces_standard) {
                    $this->custom_replaces_standard = false;
                } else {
                    $fieldarray = $this->_cm_post_insertMultiple($fieldarray);
                } // if
            } // if

            // reset $this->fieldarray which was set to a single row by insertRecord()
            $this->fieldarray = $fieldarray;
        } // if

        $this->ignore_empty_fields = false;

        return $fieldarray;

    } // insertMultiple

    // ****************************************************************************
    function insertOrUpdate ($fieldarray)
    // this will insert or update a group of records.
    {
        $this->errors = array();
        $errors = array();

        reset($fieldarray);   // fix for version 4.4.1
        if (is_string(key($fieldarray))) {
            // array is NOT indexed by row, so adjust it
            $fieldarray = array($fieldarray);
            $is_assoc = true; // this is an associative array (single row)
        } else {
            $is_assoc = false;
        } // if

        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_pre_insertOrUpdate')) {
                $fieldarray = $this->custom_processing_object->_cm_pre_insertOrUpdate($fieldarray);
            } // if
        } // if
        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            $fieldarray = $this->_cm_pre_insertOrUpdate($fieldarray);
        } // if
        if ($this->errors) {
            return $fieldarray;
        } // if

        // get array of fieldnames in the primary key
        $pkeynames = $this->getPkeyNames();

        $insert_count   = 0;
        $update_count   = 0;
        $unchange_count = 0;

        foreach ($fieldarray as $rownum => $rowdata) {

            // check if entire primary key (or candidate key) has been supplied
            list($where, $errors) = isPkeyComplete($rowdata, $pkeynames, $this->unique_keys);
            if (empty($where)) {
                // not complete, so cannot perform lookup, record must be inserted
                $count = 0;
            } else {
                // find out if this record currently exists or not
                $count = $this->getCount($where);
            } // if

            if ($count == 0) {
                // record does not exist, so create it
                $this->no_duplicate_error = true;  // don't error if this is a duplicate
                $rowdata = $this->insertRecord($rowdata);
                if ($this->numrows > 0) {
                    $insert_count++;
                } // if
            } else {
                // record already exists, so update it
                $rowdata = $this->updateRecord($rowdata);
                if ($this->numrows > 0) {
                    $update_count++;
                } else {
                    $unchange_count++;
                } // if
            } // if
            $this->no_duplicate_error = false;

            if ($this->errors) {
                if ($is_assoc) {
                    $errors = $this->errors;
                } else {
                    $errors[$rownum] = $this->errors;
                } // if
            } // if

            $fieldarray[$rownum] = $rowdata;

        } // foreach

        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_post_insertOrUpdate')) {
                $fieldarray = $this->custom_processing_object->_cm_post_insertOrUpdate($fieldarray, $insert_count, $update_count);
            } // if
        } // if
        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            $fieldarray = $this->_cm_post_insertOrUpdate($fieldarray, $insert_count, $update_count);
        } // if

        if (is_True($this->no_display_count)) {
            // do not display record count
        } else {
            // "X records inserted, X records updated in <tablename>"
            $this->messages = $this->getLanguageText('sys0098', $insert_count, $update_count, strtoupper($this->tablename));
        } // if

        $this->insert_count   = $insert_count;
        $this->update_count   = $update_count;
        $this->unchange_count = $unchange_count;
        $this->errors         = $errors;

        if ($is_assoc) {
            return $fieldarray[0]; // return an associative array
        } else {
            return $fieldarray;    // return an indexed array
        } // if

    } // insertOrUpdate

    // ****************************************************************************
    function insertRecord ($fieldarray)
    // insert a record using contents of $fieldarray.
    {
        $this->errors  = array();   // initialise
        $this->numrows = 0;

        if (!empty($fieldarray)) {
            reset($fieldarray);   // fix for version 4.4.1
            if (!is_string(key($fieldarray))) {
                // input is indexed by row, so extract data for 1st row only
                $fieldarray = $fieldarray[key($fieldarray)];
            } // if
        } // if

        // shift all field names to lower case
        $fieldarray = array_change_key_case($fieldarray, CASE_LOWER);

        // do not allow auto-insert/auto-update fields to be pasted into an insert screen
        foreach ($this->fieldspec as $field => $spec) {
            if (array_key_exists('autoinsert', $spec) or array_key_exists('autoupdate', $spec)) {
                unset($fieldarray[$field]);
            } // if
        } // foreach

        if (!empty($this->initial_values)) {
            // insert any initial values obtained from MNU_INITIAL_VALUE_ROLE/USER table
            foreach ($this->initial_values as $key => $value) {
                if (empty($fieldarray[$key])) {
                    // current value is empty, so overwrite with initial value
                    $fieldarray[$key] = $value;
                } // if
            } // foreach
        } // if

        if ($this->initiated_from_controller) {
            // deal with numbers in foreign formats (NOTE: this is now done in array_update_associative() function)
            //$fieldarray = $this->unFormatNumber($fieldarray);
            // deal with datetime in different timezones
            $fieldarray = $this->convertTimeZone($fieldarray);
        } // if

        // redo any custom initialisation
        $this->sqlSelectInit();
        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_getInitialData')) {
                $fieldarray = $this->custom_processing_object->_cm_getInitialData($fieldarray);
            } // if
        } // if
        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            $fieldarray = $this->_cm_getInitialData($fieldarray);
        } // if

        $fieldarray = array_change_key_case($fieldarray, CASE_LOWER);

        if (empty($this->errors)) {
            // perform any custom pre-insert processing
            if (is_object($this->custom_processing_object)) {
                if (method_exists($this->custom_processing_object, '_cm_pre_insertRecord')) {
                    $fieldarray = $this->custom_processing_object->_cm_pre_insertRecord($fieldarray);
                } // if
            } // if
            if ($this->custom_replaces_standard) {
                $this->custom_replaces_standard = false;
            } else {
                $fieldarray = $this->_cm_pre_insertRecord($fieldarray);
            } // if
        } // if

        $fieldarray = array_change_key_case($fieldarray, CASE_LOWER);

        $insertarray = $fieldarray;  // copy to temporary area

        if (empty($this->errors) AND is_array($insertarray) AND !empty($insertarray)) {
            // perform standard declarative checks on input array
            // NOTE: this produces another array with data formatted for the database
            $insertarray = $this->_validateInsert($insertarray);
            // replace any fields which may have been modified during the validation process
            $insertarray = array_merge($fieldarray, $insertarray);
        } // if

        if (empty($this->errors)) {
            if ($this->skip_validation OR isset($insertarray['rdc_skip_validation'])) {
                // do not perform any custom validation
            } else {
                // perform any custom pre-insert validation (1)
                if (is_object($this->custom_processing_object)) {
                    if (method_exists($this->custom_processing_object, '_cm_commonValidation')) {
                        $insertarray = $this->custom_processing_object->_cm_commonValidation($insertarray, $insertarray);
                    } // if
                } // if
                if ($this->custom_replaces_standard) {
                    $this->custom_replaces_standard = false;
                } else {
                    $insertarray = $this->_cm_commonValidation($insertarray, $insertarray);
                } // if

                if (empty($this->errors)) {
                    // perform any custom pre-insert validation (2)
                    if (is_object($this->custom_processing_object)) {
                        if (method_exists($this->custom_processing_object, '_cm_validateInsert')) {
                            $insertarray = $this->custom_processing_object->_cm_validateInsert($insertarray);
                        } // if
                    } // if
                    if ($this->custom_replaces_standard) {
                        $this->custom_replaces_standard = false;
                    } else {
                        $insertarray = $this->_cm_validateInsert($insertarray);
                    } // if
                } // if
            } // if
        } // if

        $insertarray = array_change_key_case($insertarray, CASE_LOWER);

        if (empty($this->errors)) {
            if (is_array($insertarray) AND !empty($insertarray)) {
                // perform any last minute adjustments
                foreach ($this->fieldspec as $field => $spec) {
                    if (array_key_exists($field, $insertarray)) {
                        if (array_key_exists('autoinsert', $spec) OR array_key_exists('autoupdate', $spec)) {
                            // remove any autoinsert or autoupdate fields
                            unset($insertarray[$field]);
                        } // if
                        if (!empty($insertarray[$field])) {
                            if (preg_match('/(decimal|numeric|float|real|double)/i', $spec['type'])) {
                                // remove thousands separator and ensure decimal point is '.'
                                $insertarray[$field] = number_unformat($insertarray[$field], '.', ',');
                                if (array_key_exists('scale', $spec)) {
                                    // round to the correct number of decimal places
                                    $insertarray[$field] = number_format($insertarray[$field], $spec['scale'], '.', '');
                                } // if
                            } // if
                        } // if
                    } // if
                } // foreach
                // perform standard insert using validated data
                $inserted = $this->_dml_insertRecord($insertarray);
                // replace any non-database fields not included in the insert
                $insertarray = array_merge($insertarray, $inserted);
            } // if
        } // if

        // merge temporary area with original input
        if (is_array($insertarray) AND !empty($insertarray)) {
            $fieldarray = array_merge($fieldarray, $insertarray);
        } // if

        if (empty($this->errors)) {
            // perform any custom post-insert processing
            if (is_object($this->custom_processing_object)) {
                if (method_exists($this->custom_processing_object, '_cm_post_insertRecord')) {
                    $fieldarray = $this->custom_processing_object->_cm_post_insertRecord($fieldarray);
                } // if
            } // if
            if ($this->custom_replaces_standard) {
                $this->custom_replaces_standard = false;
            } else {
                $fieldarray = $this->_cm_post_insertRecord($fieldarray);
            } // if

            $fieldarray = array_change_key_case($fieldarray, CASE_LOWER);

//            if ($this->numrows > 0 AND !empty($this->alt_language_table) AND $_SESSION['logon_user_id'] != 'INTERNET') {
//                // ensure that default entries exist for all supported languages
//                $dbobject =& RDCsingleton::getInstance($this->alt_language_table);
//                $data = array();
//                $data = $dbobject->getLanguageEntries($data, $fieldarray, $this->alt_language_cols);
//                if ($dbobject->errors) {
//                    //$this->errors = array_merge($this->errors, $dbobject->errors);
//                    $this->errors[$dbobject->getClassName()] = $dbobject->errors;
//                } // if
//                unset($dbobject);
//            } // if
        } // if

        // turn this flag off
        $this->skip_validation = FALSE;

        // store updated $fieldarray within this object
        $this->fieldarray = $fieldarray;

        return $fieldarray;

    } // insertRecord

    // ****************************************************************************
    function multiQuery ($query_array)
    // process an array of SQL queries in one go.
    {
        $result = $this->_dml_multiQuery($query_array);

        return $result;

    } // multiQuery

    // ****************************************************************************
    function popupCall (&$popupname, $where, &$script_vars, $fieldarray, &$settings)
    // processing before a popup form is called.
    // NOTE: $popupname is passed BY REFERENCE as it may be altered.
    // NOTE: $script_vars is passed BY REFERENCE as it may be altered.
    {
        // clear any previous selection
        $script_vars['selection'] = NULL;

        // the default is to select only one entry
        $settings_array['select_one'] = true;

        if (!empty($where)) {
            $where_array = where2array($where);
            foreach ($where_array as $where_field => $where_value) {
                if (!isset($fieldarray[$where_field]) OR empty($fieldarray[$where_field])) {
                    $fieldarray[$where_field] = $where_value;
                } // if
            } // foreach
        } // if

        // allow $where and $settings to be altered
        $popupname = strtolower($popupname);
        if (is_object($this->custom_processing_object)) {
            // call method which is specific to current project
            if (method_exists($this->custom_processing_object, '_cm_popupCall')) {
                $where = $this->custom_processing_object->_cm_popupCall($popupname, $where, $fieldarray, $settings_array);
            } // if
        } // if
        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            // call standard method
            $where = $this->_cm_popupCall($popupname, $where, $fieldarray, $settings_array);
        } // if

        //$script_vars['where'] = $where;  // do NOT update this value

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
            if (empty($settings)) {
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
    // $selection contains a string identifying what was selected in that popup screen.
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
            // not indexed by row, so use entire array
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
                // deal with any processing after a value has been returned
                $select_array[$field] = $selection;
                if (is_object($this->custom_processing_object)) {
                    if (method_exists($this->custom_processing_object, '_cm_popupReturn')) {
                        // call method which is specific to current project
                        $single_row = $this->custom_processing_object->_cm_popupReturn($single_row, $return_from, $select_array);
                    } // if
                } // if
                if ($this->custom_replaces_standard) {
                    $this->custom_replaces_standard = false;
                } else {
                    // call standard method
                    $single_row = $this->_cm_popupReturn($single_row, $return_from, $select_array);
                } // if
                // store updated $fieldarray within this object
                $this->fieldarray = $single_row;
            } // if
            return $single_row;
        } // if

        // convert selection string into an associative array
        $select_array = where2array($selection);

        // find entry in $fieldspec which uses this popup form
        $found = false;
        foreach ($this->fieldspec as $field => $spec) {
            if (isset($spec['task_id'])) {
                if ($spec['task_id'] == $return_from) {
                    $found = true;
                    if (isset($spec['foreign_field'])) {
                        // remove the description field obtained from the foreign table
                        unset($single_row[$spec['foreign_field']]);
                    } // if
                    // deal with any processing after a value has been returned
                    if (is_object($this->custom_processing_object)) {
                        if (method_exists($this->custom_processing_object, '_cm_popupReturn')) {
                            // call method which is specific to current project
                            $single_row = $this->custom_processing_object->_cm_popupReturn($single_row, $return_from, $select_array);
                        } // if
                    } // if
                    if ($this->custom_replaces_standard) {
                        $this->custom_replaces_standard = false;
                    } else {
                        // call standard method
                        $single_row = $this->_cm_popupReturn($single_row, $return_from, $select_array);
                    } // if

                    // look for any differences between the fieldname(s) returned by the popup
                    // and the fieldname(s) used in this table
                    foreach ($this->parent_relations as $parent) {
                        if (array_key_exists($field, $parent['fields'])) {
                            foreach ($parent['fields'] as $fld_child => $fld_parent) {
                                if ($fld_child != $fld_parent) {
                                    if (isset($select_array[$fld_parent])) {
                                        // convert the parent field name to the child field name
                                        $select_array[$fld_child] = $select_array[$fld_parent];
                                        unset($select_array[$fld_parent]);
                                    } // if
                                } // if
                            } // foreach
                            break;
                        } // if
                    } // foreach
                    // merge $selection with $fieldarray
                    $single_row = array_merge($single_row, $select_array);
                    break;
                } // if
            } // if
        } // foreach

        if ($found) {
            if ($GLOBALS['mode'] == 'insert') {
                // redo any custom initialisation
                $this->sqlSelectInit();
                if (is_object($this->custom_processing_object)) {
                    if (method_exists($this->custom_processing_object, '_cm_getInitialData')) {
                        $single_row = $this->custom_processing_object->_cm_getInitialData($single_row);
                    } // if
                } // if
                if ($this->custom_replaces_standard) {
                    $this->custom_replaces_standard = false;
                } else {
                    $single_row = $this->_cm_getInitialData($single_row);
                } // if
            } // if

            $single_row = array_change_key_case($single_row, CASE_LOWER);

            // retrieve data from foreign (parent) tables
            $single_row = $this->getForeignData($single_row);

            if ($GLOBALS['mode'] != 'search') {
                // perform any post-popup processing
                if (is_object($this->custom_processing_object)) {
                    if (method_exists($this->custom_processing_object, '_cm_post_popupReturn')) {
                        $single_row = $this->custom_processing_object->_cm_post_popupReturn($single_row, $return_from, $select_array);
                    } // if
                } // if
                if ($this->custom_replaces_standard) {
                    $this->custom_replaces_standard = false;
                } else {
                    $single_row = $this->_cm_post_popupReturn($single_row, $return_from, $select_array);
                } // if
            } // if
        } // if

        $single_row = array_change_key_case($single_row, CASE_LOWER);

        if (!empty($fieldarray) and !is_string(key($fieldarray))) {
            // insert sigle row into array
            $fieldarray[$popup_offset-1] = $single_row;
        } else {
            // not inexed by row, so replace entire array
            $fieldarray = $single_row;
        } // if

        // see if any additional data is required or needs to be changed
        $fieldarray = $this->getExtraData($fieldarray);

        // store updated $fieldarray within this object
        $this->fieldarray = $fieldarray;

        return $fieldarray;

    } // popupReturn

    // ****************************************************************************
    function post_fileUpload ($filename, $filesize)
    // perform processing after a file has been uploaded.
    {
        $this->errors = array();

        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_post_fileUpload')) {
                $this->custom_processing_object->resize_array       = $this->resize_array;
                $this->custom_processing_object->upload_subdir      = $this->upload_subdir;
                $this->custom_processing_object->upload_filetypes   = $this->upload_filetypes;
                $this->custom_processing_object->upload_maxfilesize = $this->upload_maxfilesize;
                $filename = $this->custom_processing_object->_cm_post_fileUpload($filename, $filesize);
            } // if
        } // if
        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            $filename = $this->_cm_post_fileUpload($filename, $filesize);
        } // if

        return $filename;

    } // post_fileUpload

    // ****************************************************************************
    function post_search ($search, $selection)
    // perform final processing before $search is returned to the calling program
    {
        $this->errors = array();

        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_post_search')) {
                $search = $this->custom_processing_object->_cm_post_search($search, $selection);
            } // if
        } // if

        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            $search = $this->_cm_post_search($search, $selection);
        } // if

        return $search;

    } // post_search

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

        $this->fieldarray = array();
        $where = $this->initialise($where);

        $this->setPageNo(1);

        $this->_cm_reset($where);

        return $where;

    } // reset

    // ****************************************************************************
    function restart ($return_from, $return_action, $return_string=null)
    // script is being restarted after running a child form, so check for further action.
    {
        $pattern_id = getPatternId();
        $zone       = $this->zone;

        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_restart')) {
                $this->custom_processing_object->_cm_restart($pattern_id, $zone, $return_from, $return_action, $return_string);
            } // if
        } // if

        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            $this->_cm_restart($pattern_id, $zone, $return_from, $return_action, $return_string);
        } // if

        return;

    } // restart

    // ****************************************************************************
    function rollback ()
    // rollback this transaction due to some sort of error.
    {
        // remove entries created by this task
        removeFromScriptSequence();

        $DML =& $this->_getDBMSengine($this->dbname);

        $result = $DML->rollback($this->dbname);

        $GLOBALS['transaction_has_started'] = FALSE;

        return $result;

    } // rollback

    // ****************************************************************************
    function scriptNext ($task_id, $where=null, $selection=null, $task_array=array())
    // suspend the current task before juming to a new task.
    {
        if ($GLOBALS['transaction_has_started'] == TRUE) {
            $errors = $this->commit();
            if ($errors) {
                $this->rollback();
                return false;
            } // if
        } // if

        scriptNext($task_id, $where, $selection, $task_array);

    } // scriptNext

    // ****************************************************************************
    function scriptPrevious ($errors=null, $messages=NULL, $action=NULL, $instruction=NULL)
    // go back to the previous script in the current hierarchy.
    {
        if ($GLOBALS['transaction_has_started'] == TRUE) {
            $errors = $this->commit();
            if ($errors) {
                $this->rollback();
                return false;
            } // if
        } // if

        scriptPevious($errors, $messages, $action, $instruction);

    } // scriptPrevious

    // ****************************************************************************
    function selectDB ($dbname)
    // select a different database via the current connection.
    {
        $DML =& $this->_getDBMSengine($this->dbname);

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
                foreach ($this->fieldarray as $row => $data) {
                    if (!empty($data)) {
                        $this->fieldarray[$row]['selected'] = true;
                    } // if
                } // foreach
                break;
            case 'unselectall':
                foreach ($this->fieldarray as $row => $data) {
                    if (!empty($data)) {
                        $this->fieldarray[$row]['selected'] = false;
                    } // if
                } // foreach
                break;
            default:
                $this->errors[] = $this->getLanguageText('sys0012'); // 'setAction: 2nd parameter is unknown action'
        } // switch

        return $this->fieldarray;

    } // setAction

    // ****************************************************************************
    function setChildData ($data)
    // return $fieldarray from the parent object.
    {
        if (!is_object($this->child_object)) {
            return FALSE;
        } elseif (!method_exists($this->child_object, 'setFieldArray')) {
            return FALSE;
        } // if

        $this->child_object->setFieldArray($data);

        return true;

    } // setChildData

    // ****************************************************************************
    function setChildObject (&$childOBJ)
    // insert a reference to this object's child in the current task.
    {
        if (is_object($childOBJ)) {
            $this->child_object =& $childOBJ;
        } // if

        return;

    } // setChildObject

    // ****************************************************************************
    function setCurrentOrHistoric ()
    // this table contains fields START_DATE and END_DATE, so insert into search
    // screen a dropdown list to select 'current', 'historic' or 'all' dates.
    {

        // create array of options and and put into LOOKUP_DATA
        //$array['C'] = 'Current';
        //$array['H'] = 'Historic';
        //$array['F'] = 'Future';
        $array = $this->getLanguageArray('curr_or_hist');
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
            $this->default_orderby_task = trim(strtolower($sql_orderby));
            $this->sql_orderby_seq = $this->getOrderBySeq($sql_orderby);
        } // if

        return;

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
        $dbrole =& RDCsingleton::getInstance('mnu_role');
        $dbrole_data = $dbrole->getRole();
        if ($dbrole->errors) {
            $this->errors = $dbrole->errors;
            return FALSE;
        } // if
        unset($dbrole);

        $role_id       = $dbrole_data['role_id'];
        $global_access = $dbrole_data['global_access'];

        // If the security class has GLOBAL_ACCESS = 'y' there are no restrictions.
        if ($global_access) return $array;

        $dbobject =& RDCsingleton::getInstance('mnu_role_taskfield');

        $dbobject->sql_select = 'role_id,task_id,field_id,access_type';
        $dbobject->sql_from   = 'mnu_role_taskfield ';
        $dbobject->sql_where  = "mnu_role_taskfield.role_id='$role_id' ";

        $dbobject->sql_orderby = '';
        $PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'
        $where = "task_id='" .$_SESSION['pages'][$PHP_SELF]['task_id'] ."'";

        $accessarray = $dbobject->getData_raw($where);
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
    // this allows the current data array to be set or replace.
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
                $this->fieldarray = array($fieldarray);
            } // if
        } // if

        $this->numrows = count($this->fieldarray);

        if ($this->numrows == 0) {
            $this->pageno   = 0;
            $this->lastpage = 0;
        } // if

        return $this->fieldarray;

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

        return;

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
            $where = array2where($fieldarray, $this->getPkeyNames());
        } else {
            if (!empty($input)) {
                // convert from string to an associative array
                $fieldarray = where2array($input);
                // convert back into string after removing non-Pkey fields
                $where      = array2where($fieldarray, $this->getPkeyNames());
            } else {
                $fieldarray = array();
                $where      = null;
            } // if
        } // if

        // change current table configuration (optional)
        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_changeConfig')) {
                $fieldarray = $this->custom_processing_object->_cm_changeConfig($where, $fieldarray);
            } // if
        } // if
        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            $fieldarray = $this->_cm_changeConfig($where, $fieldarray);
        } // if

        // see if any additional data is required or needs to be changed
        $fieldarray = $this->_cm_getExtraData($where, $fieldarray);

        return $fieldarray;

    } // setLookupData

    // ****************************************************************************
    function setOrderBy ($sql_orderby, $sql_orderby_seq=null, $toggle=true)
    // this allows a sort order to be changed by the user (see getData)
    {
        $this->sql_orderby = trim(strtolower($sql_orderby));

        if (empty($this->sql_orderby)) {
            $this->sql_orderby_seq  = NULL;
            $this->prev_sql_orderby = NULL;
            return;
        } // if

        // reduce orderby from 'table.column, table.column, ...' to a single column name
        $test_orderby           = reduceOrderBy($sql_orderby);
        $this->prev_sql_orderby = reduceOrderBy($this->prev_sql_orderby);

        if ($test_orderby != $this->prev_sql_orderby) {
            // column name has changed, so reset sequence to 'ASC'
            $this->sql_orderby_seq = 'asc';
        } else {
            // toggle 'orderby_seq' between 'asc' and 'desc'
            if (empty($this->sql_orderby_seq) OR $toggle === false) {
                $this->sql_orderby_seq = $sql_orderby_seq;

            } elseif (empty($sql_orderby_seq) OR $sql_orderby_seq == 'asc') {
                $this->sql_orderby_seq = 'desc';
            } else {
                $this->sql_orderby_seq = 'asc';
            } // if
        } // if

        return;

    } // setOrderBy

    // ****************************************************************************
    function setOrderBySeq ($sql_orderby_seq)
    // this allows a sort sequence ('asc' or 'desc') to be set (see getData)
    {
        $this->sql_orderby_seq = trim($sql_orderby_seq);

        return;

    } // setOrderBySeq

    // ****************************************************************************
    function setPageNo ($pageno='1')
    // this allows a particular page number to be selected (see getData)
    {
        $this->pageno = abs((int)$pageno);

        // a new page has been selected, so clear what was selected on the previous page
        $this->select_string = null;

        return;

    } // setPageNo

    // ****************************************************************************
    function setParentData ($data)
    // return $fieldarray from the parent object.
    {
        if (!is_object($this->parent_object)) {
            return FALSE;
        } elseif (!method_exists($this->parent_object, 'setFieldArray')) {
            return FALSE;
        } // if

        $this->parent_object->setFieldArray($data);

        return true;

    } // setParentData

    // ****************************************************************************
    function setParentObject (&$parentOBJ)
    // insert a reference to this object's parent in the current task.
    {
        if (is_object($parentOBJ)) {
            $this->parent_object =& $parentOBJ;
        } // if

        return;

    } // setParentObject

    // ****************************************************************************
    function setRowsPerPage ($rows_per_page)
    // this allows the default value to be changed
    {
        $this->rows_per_page = abs((int)$rows_per_page);

        return;

    } // setRowsPerPage

    // ****************************************************************************
    function setScrollArray ($where)
    // construct an array of primary keys using the contents of $where
    {
        // convert $where (string) into an array of 'name=value' pairs
        $wherearray = where2array($where);

        // call custom method to construct $this->scrollarray
        $array = $this->_cm_setScrollArray($where, $wherearray);

        //$array = array_unique($array);  // remove duplicates

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

        return;

    } // setScrollIndex

    // ****************************************************************************
    function setSelectedRows ($select_string, $rows)
    // mark any rows as 'selected' if pkey exists in select string
    {
        $select_array = splitWhereByRow($select_string);
        foreach ($select_array as $index => $string) {
            $array1 = where2array($string);     // convert string to array
            $select_array[$index] = $array1;    // replace string with array
        } // foreach

        // now compare each row of data with $select_array
        foreach ($rows as $rownum => $rowdata) {
            if (empty($select_array)) {
                break;  // no entries left, so exit
            } // if
            foreach ($select_array as $select_row => $select_array2) {
                $found = false;
                foreach ($select_array2 as $select_name => $select_value) {
                    if (!array_key_exists($select_name, $rowdata)) {
                        // this must be a dummy field, so ignore it
                    } else {
                        if ($rowdata[$select_name] == $select_value) {
                            $found = true;
                        } else {
                            $found = false;
                            break;
                        } // if
                    } // if
                } // foreach
                if ($found == true) {
                    // data matches selection, so mark this row as 'selected'
                    $rows[$rownum]['selected'] = true;
                    unset($select_array[$select_row]);
                    break;
                } // if
            } // foreach
        } // foreach

        return $rows;

    } // setSelectedRows

    // ****************************************************************************
    function setSqlSearch ($sql_search=null, $save=false)
    // set additional criteria to be used in sql select
    {
        $this->sql_search      = $sql_search;
        $this->sql_search_orig = $sql_search;

        // this causes following variables to be reset
        $this->pageno     = 1;
        $this->sql_having = null;

        // new selection criteria has been entered, so clear what was selected previously
        $this->select_string = null;

        if (!empty($sql_search) AND $save == true) {
            // save this so that it appears in the search screen
            if (!empty($this->sql_search_table)) {
                $_SESSION['search'][$this->sql_search_table] = $sql_search;
            } else {
                $_SESSION['search'][$this->tablename] = $sql_search;
            } // if
        } // if

        return;

    } // setSqlSearch

    // ****************************************************************************
    function setSqlGroupBy ($sql_groupby=null)
    // set additional criteria to be used in sql select
    {
        $this->sql_groupby = trim($sql_groupby);

        return;

    } // setSqlSearch

    // ****************************************************************************
    function setSqlWhere ($sql_where)
    // set additional criteria to be used with sql where
    {
        if (empty($this->sql_where)) {
            $this->sql_where = $sql_where;
        } else {
            $this->sql_where .= ' AND ' .$sql_where;
        } // if

        return;

    } // setSqlWhere

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
    function sqlSelectDefault ()
    // set components of the sql SELECT statement to their default values using
    // the contents of $this->parent_relations.
    {
        $save_sql_no_foreign_db = $this->sql_no_foreign_db;
        $this->sqlSelectInit();
        $this->sql_no_foreign_db = $save_sql_no_foreign_db;

        $this->sql_from = $this->_sqlForeignJoin($this->sql_select, $this->sql_from, $this->parent_relations);

        $this->access_count = 1;

        return;

    } // sqlSelectDefault

    // ****************************************************************************
    function sqlSelectInit ()
    // initialise all variables used to construct the sql SELECT statement.
    {
        $this->sql_select       = null;
        $this->sql_from         = null;
        $this->sql_where        = null;
        $this->sql_union        = null;
        $this->sql_groupby      = null;
        $this->sql_orderby      = null;
        $this->sql_orderby_seq  = null;
        $this->sql_having       = null;
        $this->sql_search       = null;
        $this->sql_search_orig  = null;
        $this->sql_search_table = null;
        $this->pageno           = null;
        //$this->rows_per_page    = null;
        $this->access_count     = null;
        //$this->sql_no_foreign_db = false;

        return;

    } // sqlSelectInit

    // ****************************************************************************
    function startTransaction ()
    // start a new transaction, to be terminated by either COMMIT or ROLLBACK.
    {
        $DML =& $this->_getDBMSengine($this->dbname);

        $GLOBALS['lock_tables'] = FALSE;    // set default, may be changed
        $GLOBALS['lock_rows']   = FALSE;    // set default, may be changed

        $this->transaction_level = null;    // set default, may be changed

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
            $std_lock['READ'] ['menu'][]     = 'mnu_initial_value_role';
            $std_lock['READ'] ['menu'][]     = 'mnu_initial_value_user';
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

            // set up an array of dbnames with its associated dprefix
            $dbprefix = $this->dbprefix; // to be used in front of database names
            $dbnames = array();
            if (empty($GLOBALS['servers'])) {
                $dbnames['*'] = $dbprefix;  // all other dbnames
            } else {
                foreach ($GLOBALS['servers'] as $servernum => $server) {
                    if ($server['dbnames'] == '*') {
                        $dbnames['*'] = $server['dbprefix'];  // all other dbnames
                    } else {
                        $dbname_array = explode(',', $server['dbnames']);
                        foreach ($dbname_array as $value) {
                            $dbnames[$value] = $server['dbprefix'];
                        } // foreach
                    } // if
                } // foreach
            } // if

            // transfer $lock_array to $new_array
            foreach ($lock_array as $mode => $mode_array) {
                foreach ($mode_array as $row => $tablename) {
                    if (strpos($tablename, '.')) {
                        // split into $dbname and $tablename
                        list($dbname, $tablename) = explode('.', $tablename);
                        if (array_key_exists($dbname, $dbnames)) {
                            $prefix = $dbnames[$dbname];
                        } else {
                            $prefix = $dbnames['*'];
                        } // if
                        $new_array[$mode][] = '"' .$prefix .$dbname .'".' .$tablename;
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
                            if (array_key_exists($std_dbname, $dbnames)) {
                                $prefix = $dbnames[$std_dbname];
                            } else {
                                $prefix = $dbnames['*'];
                            } // if
                            $new_array[$mode][] = '"' .$prefix .$std_dbname .'".' .$std_tablename;
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
        $dateobj =& RDCsingleton::getInstance('date_class');

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
                            if (empty($fieldvalue)) {
                                if (isset($fieldspec['infinityisnull'])) {
                                    if ($GLOBALS['mode'] == 'search') {
                                        // do not modify this field in a search screen
                                    } else {
                                        // empty date is shown in the database as infinity
                                        $fieldarray[$fieldname] = '9999-12-31';
                                    } // if
                                } // if
                            } else {
                                // convert date from external to internal format
                                if ($internaldate = $dateobj->getInternalDate($fieldvalue)) {
                                    // value is a valid date
                                    $fieldarray[$fieldname] = $internaldate;
                                } // if
                            } // if
                            break;
                        case 'datetime':
                            if (!empty($fieldvalue)) {
                                // convert date from external to internal format
                                if ($internaldate = $dateobj->getInternalDateTime($fieldvalue)) {
                                    // value is a valid date
                                    $fieldarray[$fieldname] = $internaldate;
                                } // if
                            } // if
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
    function unFormatNumber ($fieldarray)
    // remove any foreign formatting on numbers.
    {
//        if ($_SESSION['user_language'] == $_SESSION['default_language']) {
//            return $fieldarray;  // nothing to do
//        } // if

        foreach ($this->fieldspec as $field => $spec) {
            if (!empty($fieldarray[$field])) {
                if (preg_match('/(decimal|numeric|float|real|double|integer)/i', $spec['type'])) {
                    $fieldarray[$field] = number_unformat($fieldarray[$field]);
                } // if
            } // if
        } // foreach

        return $fieldarray;

    } // unFormatNumber

    // ****************************************************************************
    function updateFieldArray ($fieldarray, $postarray)
    // update fieldarray with data POSTed from the form.
    // NOTE: the output is passed by reference.
    {
        if ($this->errors) {
            return $this->getFieldArray();  // object has unresolved errors, so do nothing
        } // if

        // filter out any data which does not belong in this table
        $postarray = getPostArray($postarray, $this->fieldspec);

        // each item in post array may have different values for different rows,
        // so construct an array which is indexed by row number, not field name
        $rows = array();
        foreach ($postarray as $postname => $postvalue) {
            if (is_array($postvalue)) {
                foreach ($postvalue as $rownum => $value) {
                    $rownum = $rownum -1;  // post array starts at 1, fieldarray starts at 0
                    $rows[$rownum][$postname] = $value;
                } // foreach
            } else {
                // not linked with a particular row, so default to row zero
                $rows[0][$postname] = $postvalue;
            } // if
        } // foreach

        if (empty($rows)) {
            return $this->getFieldArray();  // nothing to update in this object
        } // if

        reset($fieldarray);
        if (!is_long(key($fieldarray))) {
            $fieldarray = array($fieldarray);
        } // if
        $fieldarray_out = $fieldarray;

        // deal with the changes on each row, one at a time
        foreach ($rows as $rownum => $postdata) {
            if (array_key_exists($rownum, $fieldarray)) {
                // perform any custom pre-update processing
                if (is_object($this->custom_processing_object)) {
                    if (method_exists($this->custom_processing_object, '_cm_updateFieldArray')) {
                        $fieldarray_out[$rownum] = $this->custom_processing_object->_cm_updateFieldArray($fieldarray[$rownum], $postdata, $rownum);
                    } // if
                } // if
                if ($this->custom_replaces_standard) {
                    $this->custom_replaces_standard = false;
                } else {
                    $fieldarray_out[$rownum] = $this->_cm_updateFieldArray($fieldarray[$rownum], $postdata, $rownum);
                } // if
                if (!empty($this->errors)) {
                    return $this->getFieldArray();
                } // if
                // check to see if anything has been changed
                $changes = getChanges($fieldarray_out[$rownum], $fieldarray[$rownum]);
                if (!empty($changes)) {
                    // values have been changed internally, so remove from $postarray so they don't get overwritten
                    foreach ($changes as $name => $value) {
                        if (is_array($postarray[$name])) {
                            unset($postarray[$name][$rownum+1]);
                        } else {
                            unset($postarray[$name]);
                        } // if
                    } // foreach
                } // if
            } // if
        } // foreach

        if ($this->rows_per_page == 1) {
            $fieldarray = array_update_associative($fieldarray_out[0], $postarray, $this->fieldspec);
        } else {
            $fieldarray = array_update_indexed($fieldarray_out, $postarray, $this->fieldspec);
        } // if

        // see if any additional data is required or needs to be changed
        $fieldarray = $this->getExtraData($fieldarray);

        $this->fieldarray = $fieldarray;

        return $this->getFieldArray();

    } // updateFieldArray

    // ****************************************************************************
    function updateLinkData ($fieldarray, $postarray)
    // $fieldarray is an array of field data (usually just primary keys).
    // $postarray is an array of entries which have been selected.
    // For each entry where SELECTED=TRUE make sure a database entry exists.
    // For each entry where SELECTED=FALSE make sure a database entry does not exist.
    {
        $this->errors = array();

        // perform any custom pre-update processing
        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_pre_updateLinkData')) {
                $fieldarray = $this->custom_processing_object->_cm_pre_updateLinkData($fieldarray, $postarray);
            } // if
        } // if
        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            $fieldarray = $this->_cm_pre_updateLinkData($fieldarray, $postarray);
        } // if
        if (!empty($this->errors)) return $fieldarray;

        // transfer values from $postarray to $fieldarray
        // each fieldname in $postarray contains an array of values
        foreach ($postarray as $fieldname => $valuearray) {
            if ($fieldname != 'select') {
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

        $default_orderby = $this->default_orderby; // save
        $save_sql_select = $this->sql_select;
        $save_sql_from   = $this->sql_from;
        $save_sql_search = $this->sql_search;

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

        $this->default_orderby = $default_orderby; // restore
        $this->sql_select      = $save_sql_select;
        $this->sql_from        = $save_sql_from;
        $this->sql_search_orig = $save_sql_search;

        // perform any custom post-update processing
        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_post_updateLinkData')) {
                $fieldarray = $this->custom_processing_object->_cm_post_updateLinkData($fieldarray, $postarray);
            } // if
        } // if
        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            $fieldarray = $this->_cm_post_updateLinkData($fieldarray, $postarray);
        } // if
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
        $this->no_display_count = false;
        $count                  = 0;

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

        // perform any custom validation/processing before update
        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_pre_updateMultiple')) {
                $fieldarray = $this->custom_processing_object->_cm_pre_updateMultiple($fieldarray);
            } // if
        } // if
        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            $fieldarray = $this->_cm_pre_updateMultiple($fieldarray);
        } // if

        if (empty($this->errors)) {
            // create a separate array indexed by row number
            $errors = array();
            // now update each row in the database
            foreach ($fieldarray as $row => $data) {
                $fieldarray[$row] = $this->updateRecord($data);
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

        if (is_True($this->no_display_count)) {
            // do not display record count
        } else {
            // '$count records were updated in $tablename'
            $this->messages[] = $this->getLanguageText('sys0006', $count, strtoupper($this->tablename));
        } // if

        //if (empty($this->errors)) {
            // perform any custom validation/processing after update
            if (is_object($this->custom_processing_object)) {
                if (method_exists($this->custom_processing_object, '_cm_post_updateMultiple')) {
                    $fieldarray = $this->custom_processing_object->_cm_post_updateMultiple($fieldarray);
                } // if
            } // if
            if ($this->custom_replaces_standard) {
                $this->custom_replaces_standard = false;
            } else {
                $fieldarray = $this->_cm_post_updateMultiple($fieldarray);
            } // if
        //} // if

        // store updated $fieldarray within this object
        $this->fieldarray = $fieldarray;

        return $fieldarray;

    } // updateMultiple

    // ****************************************************************************
    function updateRecord ($fieldarray)
    // update a record using the contents of $fieldarray.
    {
        if (empty($fieldarray)) return $fieldarray;

        $this->errors = array();

        reset($fieldarray);
        if (!is_string(key($fieldarray))) {
            // input is indexed by row, so extract data for 1st row only
            $fieldarray = $fieldarray[key($fieldarray)];
        } // if

        // shift all field names to lower case
        $fieldarray = array_change_key_case($fieldarray, CASE_LOWER);

        if ($this->initiated_from_controller) {
            // deal with numbers in foreign formats (NOTE: this is now done in array_update_associative() function)
            //$fieldarray = $this->unFormatNumber($fieldarray);
            // deal with datetime in different timezones
            $fieldarray = $this->convertTimeZone($fieldarray);
        } // if

        if (isset($this->fieldspec['rdcaccount_id'])) {
            if (empty($_SESSION['rdcaccount_id'])) {
                if (preg_match('/(mnu_user|mnu_account)/i', $this->tablename)) {
                    // do nothing on this table
                } else {
                    // use the 'sharing' id
                    $fieldarray['rdcaccount_id'] = 1;
                } // if
            } else {
                if ($fieldarray['rdcaccount_id'] != $_SESSION['rdcaccount_id']) {
                    // not allowed to update a shared record
                    $this->errors['rdcaccount_id'] = $this->getLanguageText('sys0189');
                } // if
                // not allowed to change the record's account
                $fieldarray['rdcaccount_id'] = $_SESSION['rdcaccount_id'];
            } // if
        } // if

        $updatearray = $fieldarray;  // copy to temporary area

        if (empty($this->errors)) {
            // perform any custom pre-update processing
            if (is_object($this->custom_processing_object)) {
                if (method_exists($this->custom_processing_object, '_cm_pre_updateRecord')) {
                    $updatearray = $this->custom_processing_object->_cm_pre_updateRecord($updatearray);
                } // if
            } // if
            if ($this->custom_replaces_standard) {
                $this->custom_replaces_standard = false;
            } else {
                $updatearray = $this->_cm_pre_updateRecord($updatearray);
            } // if
        } // if

        $updatearray = array_change_key_case($updatearray, CASE_LOWER);

        if (empty($this->errors) AND !empty($updatearray)) {
            // perform standard declarative checks on input data
            $updatearray = $this->_validateUpdate($updatearray);
            // replace any fields which may have been removed during the validation process
            $updatearray = array_merge($fieldarray, $updatearray);
        } // if

        $originaldata = array();
        if (empty($this->errors) AND !empty($updatearray)) {
            // build 'where' string using values for primary key
            $pkey_names = $this->getPkeyNames();
            if (array_key_exists('rdcversion', $this->fieldspec) AND array_key_exists('rdcversion', $updatearray)) {
                // add this field to the WHERE clause for this lookup
                $pkey_names[] = 'rdcversion';
            } // if
            $where = array2where($updatearray, $pkey_names, $this);
            // obtain copy of original record from database
            // (this may reuse previous SELECT statement which contains a JOIN)
            $originaldata = $this->_dml_ReadBeforeUpdate($where, $this->reuse_previous_select);
            $this->reuse_previous_select = false;
            if ($this->numrows <> 1) {
                // 'Could not locate original $tablename record for updating ($where)'
                $this->errors[] = $this->getLanguageText('sys0007', strtoupper($this->tablename), $where);
            } else {
                // use only 1st row in $originaldata
                $originaldata = $originaldata[key($originaldata)];
                // insert any missing values into updatearray before further validation
                $updatearray = array_merge($originaldata, $updatearray);
            } // if
        } // if

        if (empty($this->errors) AND is_array($updatearray) AND !empty($updatearray)) {
            if ($this->skip_validation) {
                // do not perform any custom validation
            } else {
                // perform any custom pre-update validation (1)
                if (is_object($this->custom_processing_object)) {
                    if (method_exists($this->custom_processing_object, '_cm_commonValidation')) {
                        $updatearray = $this->custom_processing_object->_cm_commonValidation($updatearray, $originaldata);
                    } // if
                } // if
                if ($this->custom_replaces_standard) {
                    $this->custom_replaces_standard = false;
                } else {
                    $updatearray = $this->_cm_commonValidation($updatearray, $originaldata);
                } // if

                if (empty($this->errors)) {
                    // perform any custom pre-update validation (2)
                    if (is_object($this->custom_processing_object)) {
                        if (method_exists($this->custom_processing_object, '_cm_validateUpdate')) {
                            $updatearray = $this->custom_processing_object->_cm_validateUpdate($updatearray, $originaldata);
                        } // if
                    } // if
                    if ($this->custom_replaces_standard) {
                        $this->custom_replaces_standard = false;
                    } else {
                        $updatearray = $this->_cm_validateUpdate($updatearray, $originaldata);
                    } // if
                } // if

                $updatearray = array_change_key_case($updatearray, CASE_LOWER);

            } // if
        } // if

        if (empty($this->errors)) {
            // everything OK so far, so update the database
            if (is_array($updatearray) AND !empty($updatearray)) {
                // perform any last-minute adjustments
                foreach ($this->fieldspec as $field => $spec) {
                    if (array_key_exists($field, $updatearray)) {
                        if (array_key_exists('autoinsert', $spec) OR array_key_exists('autoupdate', $spec)) {
                            // remove any autoinsert or autoupdate fields
                            unset($updatearray[$field]);
                        } // if
                        if (!empty($updatearray[$field])) {
                            if (preg_match('/(decimal|numeric|float|real|double)/i', $spec['type'])) {
                                // remove thousands separator and ensure decimal point is '.'
                                $updatearray[$field] = number_unformat($updatearray[$field], '.', ',');
                                if (preg_match("/^$field"."[+-][1-9]+/i", $updatearray[$field])) {
                                    // assume value is in format 'field+1', so let it through
                                } elseif (array_key_exists('scale', $spec)) {
                                    // round to the correct number of decimal places
                                    $updatearray[$field] = number_format($updatearray[$field], $spec['scale'], '.', '');
                                } // if
                            } // if
                        } // if
                    } // if
                } // foreach
                // find out how many fields have changed
                $changes = getChanges($updatearray, $originaldata);
            } else {
                $changes = array();
            } // if
            if (empty($changes)) {
                $this->numrows = 0;
            } else {
                // pass both the updated and the original data for processing
                $changes = $this->_dml_updateRecord($updatearray, $originaldata);
                // merge actual updates with proposed updates
                $updatearray = array_merge($updatearray, $changes);
            } // if
        } // if

        $fieldarray = array_merge($originaldata, $fieldarray);
        if (is_array($updatearray) AND !empty($updatearray)) {
            // merge temporary area with original changes
            $fieldarray = array_merge($fieldarray, $updatearray);
        } // if

        if (empty($this->errors)) {
            // perform any custom post-update processing
            if (is_object($this->custom_processing_object)) {
                if (method_exists($this->custom_processing_object, '_cm_post_updateRecord')) {
                    $fieldarray = $this->custom_processing_object->_cm_post_updateRecord($fieldarray, $originaldata);
                } // if
            } // if
            if ($this->custom_replaces_standard) {
                $this->custom_replaces_standard = false;
            } else {
                $fieldarray = $this->_cm_post_updateRecord($fieldarray, $originaldata);
            } // if
        } // if

        $fieldarray = array_change_key_case($fieldarray, CASE_LOWER);

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

        //$replace = trim($replace, ' ()');

        // perform any custom pre-processing
        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_pre_updateSelection')) {
                $selection = $this->custom_processing_object->_cm_pre_updateSelection($selection, $replace);
            } // if
        } // if

        if (empty($this->errors)) {
            // call custom method for specific processing
            $msg = $this->_cm_updateSelection($selection, $replace);
        } // if

        // perform any custom post-processing
        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_post_updateSelection')) {
                $selection = $this->custom_processing_object->_cm_post_updateSelection($selection, $replace);
            } // if
        } // if

        return $msg;

    } // updateSelection

    // ****************************************************************************
    function validateDelete ($fieldarray, $parent_table=null)
    // verify that the specified record can be deleted.
    // ($parent_table is only used in a cascade delete)
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
                // indexed by row, so use row zero only
                $fieldarray = $fieldarray[key($fieldarray)];
            } // if
        } // if

        if (isset($this->fieldspec['rdcaccount_id'])) {
            if (!empty($_SESSION['rdcaccount_id'])) {
                if ($fieldarray['rdcaccount_id'] != $_SESSION['rdcaccount_id']) {
                    // not allowed to delete a shared record
                    $this->errors['rdcaccount_id'] = $this->getLanguageText('sys0188');
                } // if
            } // if
        } // if

        // invoke custom method(s) (may be empty)
        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_validateDelete')) {
                $this->custom_processing_object->_cm_validateDelete($fieldarray, $parent_table);
            } // if
        } // if
        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            $this->_cm_validateDelete($fieldarray, $parent_table);
        } // if

        if (!empty($this->errors)) return $fieldarray;

        // check settings for any special restrictions
        foreach ($GLOBALS['settings'] as $setting_field => $setting_value) {
            $setting_field = strtolower($setting_field);
            $setting_value = strtolower($setting_value);
            if ($setting_value == '$logon_user_id') {
                if (array_key_exists($setting_field, $fieldarray)) {
                    if ($fieldarray[$setting_field] != $_SESSION['logon_user_id']) {
                        // "This record can only be deleted by its owner/creator"
                        $this->errors[] = $this->getLanguageText('sys0115');
                        return $fieldarray;
                    } // if
                } // if
            } // if
        } // foreach

        if (empty($parent_table)) {
            $parent_table = $this->tablename;
        } // if

        // all relationship data is held in a class variable
        foreach ($this->child_relations as $reldata) {
            $tblchild = $reldata['child'];
            switch(strtoupper($reldata['type'])) {
                case 'RESTRICTED':
                case 'RES':
                    // delete is not allowed if relationship is 'restricted'
                    $where = NULL;
                    foreach ($reldata['fields'] as $fldparent => $fldchild) {
                        //if (strlen($fldchild) < 1) {
                        //    $this->errors[] = $this->getLanguageText('sys0110', strtoupper($tblchild)); // 'Name of child field missing in relationship with $tblchild';
                        //    break;
                        //} // if
                        if (!empty($fldchild)) {
                            if (empty($where)) {
                                $where = "$fldchild='" .addslashes($fieldarray[$fldparent]) ."'";
                            } else {
                                $where .= ' AND ' ."$fldchild='" .addslashes($fieldarray[$fldparent]) ."'";
                            } // if
                        } // if
                    } // foreach
                    if (empty($where)) {
                        $this->errors[] = $this->getLanguageText('sys0110', strtoupper($tblchild)); // 'Name of child field missing in relationship with $tblchild';
                        break;
                    } else {
                        $where = $this->_dml_adjustWhere($where);  // replace escape character if different
                        // instantiate an object for this table
                        if (array_key_exists('subsys_dir', $reldata)) {
                            // get path to current subsystem directory
                            $dir = dirname($this->dirname);
                            // switch to other subsystem directory
                            $dir = dirname($dir) .'/' .$reldata['subsys_dir'] .'/';
                        } else {
                            $dir = NULL;
                        } // if
                        if (!class_exists($tblchild)) {
                             require_once $dir ."classes/$tblchild.class.inc";
                        } // if
                        $childobject = new $tblchild;
                        if (!empty($this->dbname_old) AND $this->dbname_old == $childobject->dbname) {
                            // name of parent database has been switched, so switch the child name as well
                            $childobject->dbname_old = $childobject->dbname;
                            $childobject->dbname     = $this->dbname;
                        } // if
                        $count = $childobject->getCount($where);
                        unset($childobject);
                        if ($count <> 0) {
                            // 'Cannot delete - record still linked to $tblchild table'
                            $this->errors[] = $this->getLanguageText('sys0008', strtoupper($tblchild));
                        } // if
                    } // if
                    break;

                case 'DELETE':
                case 'DEL':
                case 'CASCADE':
                case 'CAS':
                    // check children of this child
                    $where = NULL;
                    foreach ($reldata['fields'] as $fldparent => $fldchild) {
                        //if (strlen($fldchild) < 1) {
                        //    // 'Name of child field missing in relationship with $tblchild';
                        //    $this->errors[] = $this->getLanguageText('sys0110', strtoupper($tblchild));
                        //    break;
                        //} // if
                        if (!empty($fldchild)) {
                            if (empty($where)) {
                                $where = "$fldchild='" .addslashes($fieldarray[$fldparent]) ."'";
                            } else {
                                $where .= ' AND ' ."$fldchild='" .addslashes($fieldarray[$fldparent]) ."'";
                            } // if
                        } //if
                    } // foreach
                    if (empty($where)) {
                        $this->errors[] = $this->getLanguageText('sys0110', strtoupper($tblchild)); // 'Name of child field missing in relationship with $tblchild';
                        break;
                    } else {
                        $where = $this->_dml_adjustWhere($where);  // replace escape character if different
                        // instantiate an object for this table
                        if (array_key_exists('subsys_dir', $reldata)) {
                            // get path to current subsystem directory
                            $dir = dirname($this->dirname);
                            // switch to other subsystem directory
                            $dir = dirname($dir) .'/' .$reldata['subsys_dir'] .'/';
                        } else {
                            $dir = NULL;
                        } // if
                        if (!class_exists($tblchild)) {
                            require_once $dir ."classes/$tblchild.class.inc";
                        } // if
                        $childobject = new $tblchild;
                        if (!empty($this->dbname_old) AND $this->dbname_old == $childobject->dbname) {
                            // name of parent database has been switched, so switch the child name as well
                            $childobject->dbname_old = $childobject->dbname;
                            $childobject->dbname     = $this->dbname;
                        } // if
                        if (array_key_exists('orderby', $reldata)) {
                            $childobject->setOrderBy($reldata['orderby']);
                        } // if
                        $childarray  = $childobject->getdata($where);
                        foreach ($childarray as $child) {
                            $pkey   = $childobject->getPkeyArray($child);
                            $result = $childobject->validateDelete($pkey, $parent_table);
                            $errors = $childobject->getErrors();
                            if (!empty($errors)) {
                                $this->errors = array_merge($this->errors, $errors);
                            } // if
                        } // foreach
                        unset($childobject);
                    } // if
                    break;

                case 'NULLIFY':
                case 'NUL':
                case 'IGN':
                    //do nothing
                    break;

                case 'DEX':
                case 'NUX':
                    // do nothing as it will be handled by a foreign key constraint
                    break;

                default:
                    // 'Unknown relation type: $type'
                    $this->errors[] = $this->getLanguageText('sys0010', $reldata['type']);
            } // switch
        } // foreach

        // remove any duplicate error messages
        $this->errors = array_unique($this->errors);

        return $fieldarray;

    } // validateDelete

    // ****************************************************************************
    function validateSearch ($fieldarray)
    // validate search screen input before it is passed back to the previous form.
    {
        $this->errors = array();

        foreach ($this->fieldspec as $field => $spec) {
            if (isset($spec['required'])) {
                $fieldarray[$field] = trim($fieldarray[$field]);
                if (empty($fieldarray[$field])) {
                    // '$field cannot be blank'
                    $this->errors[$field] = $this->getLanguageText('sys0020', $field);
                } // if
            } // if
        } // foreach

        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, '_cm_validateSearch')) {
                $fieldarray = $this->custom_processing_object->_cm_validateSearch($fieldarray);
            } // if
        } // if
        if ($this->custom_replaces_standard) {
            $this->custom_replaces_standard = false;
        } else {
            $fieldarray = $this->_cm_validateSearch($fieldarray);
        } // if

        return $fieldarray;

    } // validateSearch

    // ****************************************************************************
    function validateUpdate ($fieldarray)
    // verify that the specified record can be updated.
    {
        if (is_string($fieldarray)) {
            $fieldarray = where2array($fieldarray);
        } else{
            reset($fieldarray);   // fix for version 4.4.1
            if (!is_string(key($fieldarray))) {
                // indexed by row, so use row zero only
                $fieldarray = $fieldarray[key($fieldarray)];
            } // if
        } // if

        // check settings for any special restrictions
        foreach ($GLOBALS['settings'] as $setting_field => $setting_value) {
            $setting_field = strtolower($setting_field);
            $setting_value = strtolower($setting_value);
            if ($setting_value == '$logon_user_id') {
                if (array_key_exists($setting_field, $fieldarray)) {
                    if ($fieldarray[$setting_field] != $_SESSION['logon_user_id']) {
                        // "This record can only be updated by its owner/creator"
                        $this->errors[] = $this->getLanguageText('sys0116');
                        return false;
                    } // if
                } // if
            } // if
        } // foreach

        return true;

    } // validateUpdate

    // ****************************************************************************
    // methods beginning with '_cm_' are designed to be customised as required
    // ****************************************************************************
    function _cm_changeConfig ($where, $fieldarray)
    // Change the table configuration for the duration of this instance.
    // $where = a string in SQL 'where' format.
    // $fieldarray = the contents of $where as an array.
    {
        // customisable code goes here

        return $fieldarray;

    } // _cm_changeConfig

    // ****************************************************************************
    function _cm_commonValidation ($fieldarray, $originaldata)
    // perform validation that is common to INSERT and UPDATE.
    {
        // customisable code goes here

        return $fieldarray;

    } // _cm_commonValidation

    // ****************************************************************************
    function _cm_customButton ($fieldarray, $button)
    // user pressed a custom buttom.
    {
        // custom code goes here

        return $fieldarray;

    } // _cm_customButton

    // ****************************************************************************
    function _cm_deleteSelection ($selection)
    // delete/update a selection of records in a single operation.
    {
        // remove this line after your customisation
        //trigger_error($this->getLanguageText('sys0035', get_class($this)), E_USER_ERROR); // "DELETESELECTION method has not been defined in class"

        // delete selected records.
        $from  = '';  // used in multi-table delete
        $using = '';  // used in multi-table delete
        $count = $this->_dml_deleteSelection($selection, $from, $using);

        // update selected records
        //$count = $this->_dml_updateSelection ($selection, $replace);

        // $count rows were deleted
        return $this->getLanguageText('sys0004', $count, strtoupper($this->tablename));

    } // _cm_deleteSelection

    // ****************************************************************************
    function _cm_filePickerSelect ($selection)
    // Deal with selection from a filepicker screen.
    {
        // custom code goes here

        return $selection;

    } // _cm_filePickerSelect

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
    function _cm_filterWhere ($array=null)
    // identify field names which are NOT to be filtered out of a $where string.
    {
        // custom code goes here
        //$array[] = 'whatever';

        return $array;

    } // _cm_filterWhere

    // ****************************************************************************
    function _cm_formatData ($fieldarray, &$css_array)
    // perform custom formatting before values are shown to the user.
    // Note: $css_array is passed BY REFERENCE as it may be modified.
    {
        // customisable code goes here

        return $fieldarray;

    } // _cm_formatData

    // ****************************************************************************
    function _cm_getColumnNames ($fieldarray)
    // modify data to be used by 'std.output4.inc'.
    {
        // custom code goes here

        return $fieldarray;

    } // _cm_getColumnNames

    // ****************************************************************************
    function _cm_getDatabaseLock ()
    // return array of database tables to be locked in current transaction.
    {
        $GLOBALS['lock_tables'] = FALSE;    // TRUE/FALSE
        $GLOBALS['lock_rows']   = FALSE;    // FALSE, SR (share), EX (exclusive)

        //$this->transaction_level = 'SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED';
        //$this->transaction_level = 'SET TRANSACTION ISOLATION LEVEL READ COMMITTED';
        //$this->transaction_level = 'SET TRANSACTION ISOLATION LEVEL REPEATABLE READ';  // *DEFAULT*
        //$this->transaction_level = 'SET TRANSACTION ISOLATION LEVEL SERIALIZABLE';

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
        // customisable code goes here

        return $fieldarray;

    } // _cm_getExtraData

    // ****************************************************************************
    function _cm_getForeignData ($fieldarray)
    // Retrieve data from foreign (parent) tables.
    {
        // customisable code goes here

        return $fieldarray;

    } // _cm_getForeignData

    // ****************************************************************************
    function _cm_getInitialData ($fieldarray)
    // Perform custom processing prior to insertRecord().
    // $fieldarray contains data from the initial $where clause.
    {
        // customisable code goes here

        return $fieldarray;

    } // _cm_getInitialData

    // ****************************************************************************
    function _cm_getInitialDataMultiple ($fieldarray)
    // Perform custom processing prior to insertMultiple.
    // $fieldarray contains data from the initial $where clause,
    // or current data from the outer object (if one exists).
    {
        // customisable code goes here

        return $fieldarray;

    } // _cm_getInitialDataMultiple

    // ****************************************************************************
    function _cm_getNodeData ($expanded, $where, $wherearray = null)
    // retrieve requested node data from the database.
    // $expanded may be a list of nodes to be expanded, or 'ALL' nodes.
    // $where may contain specific selection criteria as a string.
    // $wherearray is $where but converted into an array.
    {
        //DebugBreak();
        $this->sql_select  = 'x_tree_node.node_id, x_tree_node.node_desc, x_tree_level.tree_level_seq, COUNT(child.node_id) AS child_count';
        $this->sql_from    = 'x_tree_node '
                           . 'LEFT JOIN x_tree_level ON (x_tree_level.tree_type_id=x_tree_node.tree_type_id AND x_tree_level.tree_level_id=x_tree_node.tree_level_id) '
                           . 'LEFT JOIN x_tree_node AS child ON (x_tree_node.node_id=child.node_id_snr) ';
        $this->sql_where   = '';
        $this->sql_groupby = 'x_tree_node.node_id, x_tree_node.node_desc, x_tree_node.tree_level_id, x_tree_level.tree_level_seq';
        $this->sql_having  = '';
        $this->sql_orderby = 'x_tree_node.tree_level_id, x_tree_node.node_id';

        if (!empty($this->alt_language_table)) {
            if ($_SESSION['user_language'] != $_SESSION['default_language']) {
                // link to table which provides text in an alternative language
                $pkey_array = array();
                foreach ($this->primary_key as $fieldname) {
                    $pkey_array[$fieldname] = $fieldname;
                } // foreach
                $new_relation = array('parent' => $this->alt_language_table,
                                      'parent_field' => $this->alt_language_cols,
                                      'fields' => $pkey_array);
                $new_relation['this'] = 'x_tree_node';
                $this->sql_select = $this->_sqlSelectAlternateLanguage($this->sql_select, $new_relation);
            } // if
        } // if

        if (array_key_exists('tree_type_id', $wherearray)) {
            // look for root nodes within this tree_type
            $wherearray['tree_level_seq'] = 1;
            $where = array2where($wherearray);
        } // if

        $data_raw = $this->getData($where);

        foreach ($data_raw as $row => $rowdata) {
            // append data for current node to output array
            $fieldarray[] = $rowdata;
            $node_id = $rowdata['node_id'];
            if ($rowdata['child_count'] > 0) {
                // child nodes exist, but do we expand them?
                if ($expanded == 'ALL' or array_key_exists($node_id, $expanded)) {
                    // tell system this row has been expanded
                    $fieldarray[count($fieldarray)-1]['expanded'] = 'y';
                    // this replaces 'ALL' with a list of actual nodes
                    $this->expanded[$node_id] = true;
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
    function _cm_getOrderBy ($orderby)
    // Adjust name of orderby item before it is used in an sql SELECT statement.
    {
        // customisable code goes here

        return $orderby;

    } // _cm_getOrderBy

    // ****************************************************************************
    function _cm_getPkeyNames ($pkey_array, $task_id, $pattern_id)
    // return the list of primary key fields in this table before the selection string
    // is constructed and passed to another form.
    // $pkey_array contains the current list of primary key fields.
    // $task_id identifies the task to which the primary key(s) will be passed.
    // $pattern_id identifies the task's pattern.
    {
        //$pkey_array[] = 'whatever';       // append to array
        //$pkey_array = array('whatever');  // replace array

        return $pkey_array;

    } // _cm_getPkeyNames

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
//            $data = $this->getData($where);
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
//            $array = $this->getLanguageArray('item2');
//            return $array;
//        } // if

        return $array;

    } // _cm_getValRep

    // ****************************************************************************
    function _cm_getWhere ($where, $task_id, $pattern_id)
    // allow WHERE string to be customised before being passed to next task.
    {
        // custom code goes here

        return $where;

    } // _cm_getWhere

    // ****************************************************************************
    function _cm_initialise ($where, &$selection, $search)
    // perform any initialisation for the current task.
    // NOTE: $selection is passed by reference as it may be amended.
    // NOTE: $search    is only available for OUTPUT tasks.
    {
        // customisable code goes here

//        $pattern_id = getPatternId();
//        if (preg_match('/^(add)/i', $pattern_id)) {
//            // ignore contents of selection
//            $selection = null;
//        } else {
//            if (!empty($selection)) {
//                $where     = $selection;
//                $selection = null;
//            } // if
//        } // if

        return $where;

    } // _cm_initialise

    // ****************************************************************************
    function _cm_initialiseFileDownload ($fieldarray)
    // perform any initialisation for the file download operation.
    {
        //$this->download_filename = $fieldarray['download_filename'];
        //$this->download_mode     = 'inline';  // disable option to save

        return $fieldarray;

    } // _cm_initialiseFileDownload

    // ****************************************************************************
    function _cm_initialiseFilePicker ($fieldarray, $search)
    // perform any initialisation before displaying the File Picker screen.
    {
        // identify the subdirectory which contains the files
        $this->picker_subdir      = 'filepickersubdirectory';

        // identify the file types that may be picked
        $this->picker_filetypes   = array();  // default is ANY file extension
        $this->picker_filetypes   = array('txt', 'bmp', 'doc');

        return $fieldarray;

    } // _cm_initialiseFilePicker

    // ****************************************************************************
    function _cm_initialiseFileUpload ($fieldarray)
    // perform any initialisation before displaying the File Upload screen.
    {
        $this->upload_subdir      = 'uploadedfiles';
        //$this->upload_filetypes   = array('image/x-png', 'image/gif');
        $this->upload_filetypes   = 'image';  // for any type of image
        $this->upload_maxfilesize = 100;

        return $fieldarray;

    } // _cm_initialiseFileUpload

    // ****************************************************************************
    function _cm_ListView_header ($fieldarray)
    // insert data into $fieldarray before title is printed in List View
    {
        // customisable code goes here

        return $fieldarray;

    } // _cm_ListView_header

    // ****************************************************************************
//    function _cm_ListView_pre_print ($prev_row, $curr_row)
//    // allow extra rows to be created in List View
//    {
//        $rows = array();
//
//        // this is deprecated - use _cm_ListView_print_before() and _cm_ListView_print_after() instead
//
//        return $rows;
//
//    } // _cm_ListView_pre_print

    // ****************************************************************************
    function _cm_ListView_print_before ($prev_row, $curr_row)
    // allow extra rows to be created in List View
    {
        $output = array();

        // customisable code goes here

        return $output;

    } // _cm_ListView_print_before

    // ****************************************************************************
    function _cm_ListView_print_after ($curr_row, $next_row)
    // allow extra rows to be created in List View
    {
        $output = array();

        // customisable code goes here

        return $output;

    } // _cm_ListView_print_after

    // ****************************************************************************
    function _cm_ListView_total ()
    // pass back any data to be printed on last line of PDF report (list view).
    {
        $array = array();

        // customisable code goes here

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
    function _cm_popupCall (&$popupname, $where, $fieldarray, &$settings)
    // if a popup button has been pressed the contents of $where may need to
    // be altered before the popup screen is called.
    // NOTE: $settings is passed BY REFERENCE as it may be altered as well.
    // NOTE: $popupname is passed BY REFERENCE as it may be altered as well.
    {
        // clear out the contents of $where
        //$where = '';

        // allow only one entry to be selected (the default)
        $settings['select_one'] = true;

        // allow more than one entry to be selected
        //$settings['select_one'] = false;

        // allow a single result to be selected without user intervention
        //$settings['choose_single_row'] = true;

        if ($popupname == 'con_content(filepicker)') {
            // replace $where for this popup
            $where = "$where";
        } else {
            $where = '';
        } // if

        return $where;

    } // _cm_popupCall

    // ****************************************************************************
    function _cm_popupReturn ($fieldarray, $return_from, &$select_array)
    // process a selection returned from a popup screen.
    // $fieldarray contains the record data when the popup button was pressed.
    // $return_from identifies which popup screen was called.
    // $select_array contains an array of item(s) selected in that popup screen.
    // NOTE: $select_array is passed BY REFERENCE so that it can be modified.
    {
        if ($return_from == '???(popup)') {
            // change field name from 'foo_id' to 'bar_id'
            $select_array['bar_id'] = $select_array['foo_id'];
            unset($select_array['foo_id']);
        } // if

        return $fieldarray;

    } // _cm_popupReturn

    // ****************************************************************************
    function _cm_post_deleteMultiple ($rows)
    // perform custom processing after multiple database records have been deleted.
    {
        // customisable code goes here

        return $rows;

    } // _cm_post_deleteMultiple

    // ****************************************************************************
    function _cm_post_deleteRecord ($fieldarray)
    // perform custom processing after database record has been deleted.
    {
        // customisable code goes here

        return $fieldarray;

    } // _cm_post_deleteRecord

    // ****************************************************************************
    function _cm_post_eraseRecord ($fieldarray)
    // perform custom processing after database record has been erased.
    {
        // customisable code goes here

        return $fieldarray;

    } // _cm_post_eraseRecord

    // ****************************************************************************
    function _cm_post_fetchRow ($fieldarray)
    // perform custom processing after a call to fetchRow().
    {
        // customisable code goes here

        return $fieldarray;

    } // _cm_post_fetchRow

    // ****************************************************************************
    function _cm_post_fileUpload ($filename, $filesize)
    // perform processing after a file has been uploaded.
    {
        // custom processing goes here

        return;

    } // _cm_post_fileUpload

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
        // customisable code goes here

        return $rows;

    } // _cm_post_insertMultiple

    // ****************************************************************************
    function _cm_post_insertOrUpdate ($fieldarray, $insert_count, $update_count)
    // perform custom processing at end of insertOrUpdate() method.
    {
        // customisable code goes here

        return $fieldarray;

    } // _cm_post_insertOrUpdate

    // ****************************************************************************
    function _cm_post_insertRecord ($rowdata)
    // perform custom processing after database record has been inserted.
    {
        // customisable code goes here

        return $rowdata;

    } // _cm_post_insertRecord

    // ****************************************************************************
    function _cm_post_lastRow ()
    // perform custom processing after last record has been read.
    {
        $fieldarray = array();

        // customisable code goes here

        return $fieldarray;

    } // _cm_post_fetchRow

    // ****************************************************************************
    function _cm_post_output ($string, $filename)
    // perform any processing required after the output operation
    {
        // customisable code goes here

        return $string;

    } // _cm_post_output

    // ****************************************************************************
    function _cm_post_popupReturn ($fieldarray, $return_from, $select_array)
    // perform any post-popup processing.
    {
        // customisable code goes here

        return $fieldarray;

    } // _cm_post_popupReturn

    // ****************************************************************************
    function _cm_post_search ($search, $selection)
    // perform any post-search processing.
    {
        // customisable code goes here

        return $search;

    } // _cm_post_search

    // ****************************************************************************
    function _cm_post_updateLinkdata ($rows, $postarray)
    // perform custom processing after multiple database records have been updated.
    {
        // customisable code goes here

        return $rows;

    } // _cm_post_updateLinkData

    // ****************************************************************************
    function _cm_post_updateMultiple ($rows)
    // perform custom processing after multiple database records have been updated.
    {
        // customisable code goes here

        return $rows;

    } // _cm_post_updateMultiple

    // ****************************************************************************
    function _cm_post_updateRecord ($rowdata, $old_data)
    // perform custom processing after database record is updated.
    {
        // customisable code goes here

        return $rowdata;

    } // _cm_post_updateRecord

    // ****************************************************************************
    function _cm_post_updateSelection ($selection, $replace)
    // allow changes to be made after _cm_updateSelection method has been called.
    {
        // custom code goes here

        return $selection;

    } // _cm_post_updateSelection

    // ****************************************************************************
    function _cm_pre_cascadeDelete ($fieldarray)
    // perform custom processing before database record is deleted as part of a
    // cascade delete.
    {
        // customisable code goes here

        return $fieldarray;

    } // _cm_pre_cascadeDelete

    // ****************************************************************************
    function _cm_pre_deleteMultiple ($rows)
    // perform custom processing before multiple database records are deleted.
    // if anything is placed in $this->errors the delete will be terminated.
    {
        // customisable code goes here

        return $rows;

    } // _cm_pre_deleteMultiple

    // ****************************************************************************
    function _cm_pre_deleteRecord ($rowdata)
    // perform custom processing before database record is deleted.
    // if anything is placed in $this->errors the deletion will be terminated.
    {
        // customisable code goes here

        return $rowdata;

    } // _cm_pre_deleteRecord

    // ****************************************************************************
    function _cm_pre_eraseRecord ($rowdata)
    // perform custom processing before database record is erased.
    // if anything is placed in $this->errors the erasure will be terminated.
    {
        // customisable code goes here

        return $rowdata;

    } // _cm_pre_eraseRecord

    // ****************************************************************************
    function _cm_pre_getData ($where, $where_array, $fieldarray=null)
    // perform custom processing before database record(s) are retrieved.
    // (WHERE is supplied in two formats - string and array)
    // $fieldarray may contain full details of the current record in the parent
    // class, not just its primary key.
    {
        // customisable code goes here

//        if (empty($this->sql_from)) {
//            // construct default SELECT and FROM clauses using parent relations
//            $this->sql_from    = null;
//            $this->sql_groupby = null;
//            $this->sql_having  = null;
//            $this->sql_union   = null;
//            $this->sql_from    = $this->_sqlForeignJoin($this->sql_select, $this->sql_from, $this->parent_relations);
//        } // if

        return $where;

    } // _cm_pre_getData

    // ****************************************************************************
    function _cm_pre_insertMultiple ($rows)
    // perform custom processing before multiple database records are inserted.
    // if anything is placed in $this->errors the insert will be terminated.
    {
        // customisable code goes here

        return $rows;

    } // _cm_pre_insertMultiple

    // ****************************************************************************
    function _cm_pre_insertOrUpdate ($rows)
    // perform custom processing at start of insertOrUpdate() method.
    // if anything is placed in $this->errors the operation will be terminated.
    {
        // customisable code goes here

        return $rows;

    } // _cm_pre_insertOrUpdate

    // ****************************************************************************
    function _cm_pre_insertRecord ($rowdata)
    // perform custom processing before database record is inserted.
    // if anything is placed in $this->errors the insert will be terminated.
    {
        // customisable code goes here

        return $rowdata;

    } // _cm_pre_insertRecord

    // ****************************************************************************
    function _cm_pre_output ($filename)
    // perform any processing required before the output operation.
    // $filename is only available if the output is being sent to a disk file.
    {
        // customisable code goes here

        return $filename;

    } // _cm_pre_output

    // ****************************************************************************
    function _cm_pre_updateLinkdata ($rows, &$postarray)
    // $rows is an array of field data (multiple rows).
    // $postarray is an array of entries which have been selected.
    // NOTE: $postarray is passed BY REFERENCE so that it may be modified.
    // NOTE: $rows starts at 0, $select starts at 1.
    // if anything is placed in $this->errors the update will be terminated.
    {
        // customisable code goes here

        return $rows;

    } // _cm_pre_updateLinkData

    // ****************************************************************************
    function _cm_pre_updateMultiple ($rows)
    // perform custom processing before multiple database records are updated.
    {
        // customisable code goes here

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

        // reuse existing SELECT statement in _dml_ReadBeforeUpdate() method
        //$this->reuse_previous_select = true;

        return $rowdata;

    } // _cm_pre_updateRecord

    // ****************************************************************************
    function _cm_pre_updateSelection ($selection, $replace)
    // allow changes to be made before _cm_updateSelection method is called.
    {
        // custom code goes here

        return $selection;

    } // _cm_pre_updateSelection

    // ****************************************************************************
    function _cm_reset ($where)
    // perform custom processing after RESET button is pressed.
    {
        // customisable code goes here

        return;

    } // _cm_reset

    // ****************************************************************************
    function _cm_restart ($pattern_id, $zone, $return_from, $return_action, $return_string)
    // script is being restarted after running a child form, so check for further action.
    {
        // customisable code goes here

        return;

    } // _cm_restart

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
        // customisable code goes here

        return $fieldarray;

    } // _cm_unFormatData

    // ****************************************************************************
    function _cm_updateFieldarray ($fieldarray, $postarray, $rownum)
    // allow object to deal with any changes POSTed from the form.
    // $fieldarray contains current data from one row.
    // $postarray contains any changes made in the form for this row.
    // $rownum identifies which row is being processed
    {
        // customisable code goes here

        return $fieldarray;

    } // _cm_updateFieldarray

    // ****************************************************************************
    function _cm_updateSelection ($selection, $replace)
    // update multiple rows in a single operation.
    {
        if ($this->dbname == 'default' AND $this->tablename == 'default') {
            // possibly called from custom processing object, so do nothing
            return;
        } // if

        if (!is_string($selection) OR empty($replace)) {
            // this combination is not valid
            return;
        } else {
            // this is the default code, which may be replaced if necessary
            $count = $this->_dml_updateSelection($selection, $replace);

            // '$count records were updated in $tablename'
            return $this->getLanguageText('sys0006', $count, strtoupper($this->tablename));
        } // if

    } // _cm_updateSelection

    // ****************************************************************************
    function _cm_validateDelete ($rowdata, $parent_table)
    // verify that the selected record can be deleted.
    // ($parent_table is only used in a cascade delete)
    // if anything is placed in $this->errors the delete will be terminated.
    {
        // customisable code goes here

        return;

    } // _cm_validateDelete

    // ****************************************************************************
    function _cm_validateInsert ($rowdata)
    // perform custom validation before an insert.
    // if anything is placed in $this->errors the insert will be terminated.
    {
        // customisable code goes here

        return $rowdata;

    } // _cm_validateInsert

    // ****************************************************************************
    function _cm_validateSearch ($fieldarray)
    // perform custom validation on data entered via a search screen.
    // put any errors into $this->errors.
    {
        // customisable code goes here

        return $fieldarray;

    } // _cm_validateSearch

    // ****************************************************************************
    function _cm_validateUpdate ($fieldarray, $originaldata)
    // perform custom validation before update.
    // if anything is placed in $this->errors the update will be terminated.
    {
        // customisable code goes here

        return $fieldarray;

    } // _cm_validateUpdate

    // ****************************************************************************
    // methods beginning with '_ddl_' are for calling the Database Access object
    // (for commands using the Data Definition Language)
    // ****************************************************************************
    function _ddl_getColumnSpecs ()
    // obtain column specifications.
    {
        $DDL =& $this->_getDBMSengine($this->dbname);

        $array = $DDL->ddl_getColumnSpecs();

        return $array;

    } // _ddl_getColumnSpecs

    // ****************************************************************************
    function _ddl_showColumns($dbname, $tablename)
    // obtain a list of column names for the selected database table.
    {
        $DDL =& $this->_getDBMSengine($dbname);

        $array = $DDL->ddl_showColumns($dbname, $tablename);

        return $array;

    } // _ddl_showColumns

    // ****************************************************************************
    function _ddl_showCreateTable ($dbname, $tablename)
    // obtain a list of column names for the selected database table.
    {
        $DDL =& $this->_getDBMSengine($dbname);

        $array = $DDL->ddl_showCreateTable($dbname, $tablename);

        return $array;

    } // _ddl_showCreateTable

    // ****************************************************************************
    function _ddl_showDatabases ($dbprefix)
    // obtain a list of existing database names.
    {
        $DDL =& $this->_getDBMSengine($this->dbname);

        $array = $DDL->ddl_showDatabases($dbprefix);

        return $array;

    } // _ddl_showDatabases

    // ****************************************************************************
    function _ddl_showTables ($dbname)
    // obtain a list of table names for the selected database.
    {
        $DDL =& $this->_getDBMSengine($dbname);

        $array = $DDL->ddl_showTables($dbname);

        return $array;

    } // _ddl_showTables

    // ****************************************************************************
    function _ddl_showTableKeys ($dbname, $tablename)
    // obtain a list of existing database names.
    {
        $DDL =& $this->_getDBMSengine($dbname);

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
        if (empty($fieldarray)) {
            return;  // nothing to delete
        } // if

        $DML =& $this->_getDBMSengine($this->dbname);

        $DML->fieldspec     = $this->fieldspec;
        $DML->audit_logging = $this->audit_logging;
        $DML->primary_key   = $this->getPkeyNames();

        // remove any non-database fields from input array
        foreach ($fieldarray as $field => $fieldvalue) {
            // check that $field exists in $fieldspec array
            if (!array_key_exists($field, $DML->fieldspec)) {
                // it does not (like the SUBMIT button, for example), so remove it
                unset($fieldarray[$field]);
            } // if
        } // foreach

        $DML->deleteRecord($this->dbname, $this->tablename, $fieldarray);

        $this->errors  = array_merge($DML->getErrors(), $this->errors);
        $this->numrows = $DML->getNumRows();

        return;

    } // _dml_deleteRecord

    // ****************************************************************************
    function _dml_adjustWhere ($string_in)
    // the DBMS may require different escape characters, so adjust as necessary.
    {
        $DML =& $this->_getDBMSengine($this->dbname);

        if (method_exists($DML, 'adjustWhere')) {
            $string_out = $DML->adjustWhere($string_in);
        } else {
            $string_out = $string_in;
        } // if

        return $string_out;

    } // _dml_adjustWhere

    // ****************************************************************************
    function _dml_deleteSelection ($selection, $from=null, $using=null)
    // delete a selection of records in a single operation.
    {
        $DML =& $this->_getDBMSengine($this->dbname);

        $DML->fieldspec     = $this->fieldspec;
        $DML->audit_logging = $this->audit_logging;

        if (!$this->audit_logging OR defined('TRANSIX_NO_AUDIT') OR defined('NO_AUDIT_LOGGING')) {
            // no audit logging, so delete everything in one operation
            $count = $DML->deleteSelection($this->dbname, $this->tablename, $selection, $from, $using);
            $this->errors = array_merge($DML->getErrors(), $this->errors);
        } else {
            $this->sqlSelectInit();
            // audit logging is ON, so fetch everything and delete one row at a time
            $resource = $this->_dml_getData_serial($selection);
            $count    = $this->numrows;
            $errors   = array();
            while ($row = $this->fetchRow($resource)) {
                $this->deleteRecord($row);
                $errors = array_merge($this->getErrors(), $errors);
            } // while
            $this->errors = $errors;
        } // if

        $this->numrows = $count;

        return $count;

    } // _dml_deleteSelection

    // ****************************************************************************
    function _dml_free_result ($resource)
    // Get count of recors which match criteria in $where.
    {
        $DML =& $this->_getDBMSengine($this->dbname);

        $result = $DML->free_result($this->dbname, $resource);

        return $result;

    } // _dml_free_result

    // ****************************************************************************
    function _dml_getCount ($where)
    // Get count of recors which match criteria in $where.
    {
        $DML =& $this->_getDBMSengine($this->dbname);

        $count = $DML->getCount($this->dbname, $this->tablename, $where);

        if (is_null($count)) {
            $count = 0;
        } // if

        $this->errors = array_merge($DML->getErrors(), $this->errors);

        return $count;

    } // _dml_getCount

    // ****************************************************************************
    function _dml_getData ($where, $raw=false)
    // Get data from the specified database table.
    // Results may be affected by $where and $pageno.
    {
        $DML =& $this->_getDBMSengine($this->dbname);

        $DML->fieldspec        = $this->fieldspec;
        $DML->pageno           = $this->pageno;
        $DML->rows_per_page    = $this->rows_per_page;
        $DML->sql_select       = $this->sql_select;
        $DML->sql_from         = $this->sql_from;
        $DML->sql_groupby      = $this->sql_groupby;
        $DML->sql_having       = $this->sql_having;

        if (!empty($this->sql_union)) {
            if (substr(trim($this->sql_union), 0, 1) != '(') {
                // this string must be enclosed in '(' and ')'
                $this->sql_union = '('.trim($this->sql_union).')';
            } // if
            $DML->sql_union    = $this->sql_union;
        } // if

        $DML->sql_orderby      = $this->getOrderBy();
        $DML->sql_orderby_seq  = $this->sql_orderby_seq;
        if (!empty($DML->sql_orderby) AND $raw === true) {
            $DML->sql_orderby = validateSortItem2 ($DML->sql_orderby, $DML->sql_select, $DML->fieldspec);
        } // if
        $this->prev_sql_orderby = $DML->sql_orderby;

        $DML->setRowLocks($this->row_locks);

        $array = $DML->getData($this->dbname, $this->tablename, $where);

        $this->errors   = array_merge($DML->getErrors(), $this->errors);
        $this->numrows  = $DML->getNumRows();
        $this->pageno   = $DML->getPageNo();
        $this->lastpage = $DML->getLastPage();

        $this->sql_union = null;

        return $array;

    } // _dml_getData

    // ****************************************************************************
    function _dml_getData_serial ($where=null, $rdc_limit=null, $rdc_offset=null, $unbuffered_query=false)
    // Issue an SQL query and return result, not an array of data.
    // Individual rows will be returned using the fetchRow() method.
    {
        $this->errors = array();

        $DML =& $this->_getDBMSengine($this->dbname, $unbuffered_query);

        $DML->fieldspec        = $this->fieldspec;
        $DML->pageno           = $this->pageno;
        $DML->rows_per_page    = $this->rows_per_page;
        $DML->sql_select       = $this->sql_select;
        $DML->sql_from         = $this->sql_from;
        $DML->sql_groupby      = $this->sql_groupby;
        $DML->sql_having       = $this->sql_having;

        if (!empty($this->sql_union)) {
            if (substr(trim($this->sql_union), 0, 1) != '(') {
                // this string must be enclosed in '(' and ')'
                $this->sql_union = '('.trim($this->sql_union).')';
            } // if
            $DML->sql_union    = $this->sql_union;
        } // if

        $DML->sql_orderby      = $this->getOrderBy();
        $DML->sql_orderby_seq  = $this->sql_orderby_seq;

        $result = $DML->getData_serial($this->dbname, $this->tablename, $where, $rdc_limit, $rdc_offset);

        $this->numrows  = $DML->getNumRows();

        return $result;

    } // _dml_getData_serial

    // ****************************************************************************
    function _dml_getEnum ($item)
    // Get the details of an ENUM item from the database.
    {
        $DML =& $this->_getDBMSengine($this->dbname);

        $array = $DML->getEnum($this->dbname, $this->tablename, $item);

        $this->errors = array_merge($DML->getErrors(), $this->errors);

        return $array;

    } // _dml_getEnum

    // ****************************************************************************
    function _dml_insertRecord ($fieldarray)
    // insert a record using the contents of $fieldarray.
    {
        $DML =& $this->_getDBMSengine($this->dbname);

        // use ORIGINAL, not CURRENT specifications for this database table
        $DML->fieldspec               = $this->getFieldSpec_original();
        // include other important variables
        $DML->primary_key             = $this->getPkeyNames();
        $DML->unique_keys             = $this->unique_keys;
        $DML->audit_logging           = $this->audit_logging;
        $DML->no_duplicate_error      = $this->no_duplicate_error;
        $DML->retry_on_duplicate_key  = $this->retry_on_duplicate_key;
        $DML->update_on_duplicate_key = $this->update_on_duplicate_key;
        $DML->allow_db_function       = $this->allow_db_function;

        // remove any non-database fields from input array
        foreach ($fieldarray as $field => $fieldvalue) {
            // check that $field exists in $fieldspec array
            if (!array_key_exists($field, $DML->fieldspec)) {
                // it does not (like the SUBMIT button, for example), so remove it
                unset ($fieldarray[$field]);
            } // if
        } // foreach

        $array = $DML->insertRecord($this->dbname, $this->tablename, $fieldarray);

        $this->errors  = array_merge($this->errors, $DML->getErrors());
        if (method_exists($DML, 'getMessages')) {
            $this->messages = array_merge($this->messages, $DML->getMessages());
        } // if
        $this->numrows = $DML->numrows;
        if ($this->numrows > 0) {
            $this->insert_count = $this->numrows;
        } else {
            $this->unchanged_count = 1;
        } // if

        $this->query = $DML->query;  // save this in case trigger_error() is called

        $this->retry_on_duplicate_key  = false;
        $this->update_on_duplicate_key = false;
        $this->allow_db_function       = array();

        return $array;

    } // _dml_insertRecord

    // ****************************************************************************
    function _dml_multiQuery ($query)
    // perform multiple queries in a single step. (DEPRECATED)
    {
        $result = $this->executeQuery($query);

        return $result;

    } // _dml_multiQuery

    // ****************************************************************************
    function _dml_ReadBeforeUpdate ($where, $reuse_previous_select=false)
    // Read a single record just before it is updated.
    // The primary key should be supplied in $where.
    {
        $DML =& $this->_getDBMSengine($this->dbname);

        $DML->fieldspec        = $this->fieldspec;
        $DML->pageno           = 1;
        $DML->rows_per_page    = 0;
        if (is_True($reuse_previous_select)) {
            if (empty($this->sql_select)) {
                // has not been constructed yet, so do it now
                $where_array = where2array($where);
                $where = $this->_cm_pre_getData ($where, $where_array, $this->fieldarray);
            } // if
            $having_array = array();
            $where = qualifyWhere($where, $this->tablename, $this->fieldspec, $this->sql_from, null, null, $having_array);
            // use previous SELECT statement
            $DML->sql_select       = $this->sql_select;
            if (!empty($DML->sql_select)) {
                // ensure this selects ALL fields from the primary table
                if (!preg_match('/' .$this->tablename .'\.\*/', $DML->sql_select)) {
                    $DML->sql_select = $this->tablename .'.*, ' .$DML->sql_select;
                } // if
            } // if
            $DML->sql_from         = $this->sql_from;
            $DML->sql_groupby      = $this->sql_groupby;
            $DML->sql_having       = $this->sql_having;
            $DML->sql_orderby      = $this->getOrderBy();
            $DML->sql_orderby_seq  = $this->sql_orderby_seq;
        } else {
            // construct default SELECT statement
            $DML->sql_select       = NULL;
            $DML->sql_from         = NULL;
            $DML->sql_groupby      = NULL;
            $DML->sql_having       = NULL;
            $DML->sql_orderby      = NULL;
            $DML->sql_orderby_seq  = NULL;
        } // if
        $DML->setRowLocks('EX');   // lock this row (exclusive)

        $array = $DML->getData($this->dbname, $this->tablename, $where);

        $this->errors  = array_merge($DML->getErrors(), $this->errors);
        $this->numrows = $DML->getNumRows();

        return $array;

    } // _dml_ReadBeforeUpdate

    // ****************************************************************************
    function _dml_updateRecord ($fieldarray, $oldarray, $where=null)
    // update the record contained in $fieldarray.
    {
        $DML =& $this->_getDBMSengine($this->dbname);

        // use ORIGINAL, not CURRENT specifications for this database table
        $DML->fieldspec         = $this->getFieldSpec_original();
        $DML->primary_key       = $this->getPkeyNames();
        $DML->unique_keys       = $this->unique_keys;
        $DML->audit_logging     = $this->audit_logging;
        $DML->allow_db_function = $this->allow_db_function;

        // remove any non-database fields from input array
        foreach ($fieldarray as $field => $fieldvalue) {
            // check that $field exists in $fieldspec array
            if (!array_key_exists($field, $DML->fieldspec)) {
                // it does not (like the SUBMIT button, for example), so remove it
                unset($fieldarray[$field]);
            } // if
        } // foreach

        $array = $DML->updateRecord($this->dbname, $this->tablename, $fieldarray, $oldarray, $where);

        $this->errors  = array_merge($this->errors, $DML->getErrors());
        if (method_exists($DML, 'getMessages')) {
            $this->messages = array_merge($this->messages, $DML->getMessages());
        } // if
        $this->numrows = $DML->getNumRows();

        $this->query = $DML->query;  // save this in case trigger_error() is called

        $this->allow_db_function = array();

        return $array;

    } // _dml_updateRecord

    // ****************************************************************************
    function _dml_updateSelection ($selection, $replace)
    // update a selection of records in a single operation.
    {
        $DML =& $this->_getDBMSengine($this->dbname);

        $DML->fieldspec         = $this->fieldspec;
        $DML->audit_logging     = $this->audit_logging;
        $DML->allow_db_function = $this->allow_db_function;

        if (!$this->audit_logging) {
            // no audit logging, so update everything in one operation
            $count = $DML->updateSelection($this->dbname, $this->tablename, $replace, $selection);
            $this->errors = array_merge($this->errors, $DML->getErrors());
            if (method_exists($DML, 'getMessages')) {
                $this->messages = array_merge($this->messages, $DML->getMessages());
            } // if
        } else {
            $this->sqlSelectInit();
            // audit logging is ON, so fetch everything and update one row at a time
            $resource = $this->_dml_getData_serial($selection);
            $count = 0;
            while ($row = $this->fetchRow($resource)) {
                $update = where2array($replace);
                $update = array_merge($row, $update);
                // construct primary key for original record as this may be changed in this update
                $where  = array2where($row, $this->getPkeyNames());
                $this->_dml_updateRecord($update, $row, $where);
                if ($this->errors) {
                    break;
                } // if
                $count += $this->numrows;
            } // while
        } // if

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
            $context    = array2where($input, $this->getPkeyNames(), false, true);
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

        if (empty($context)) {
            return $this->errors;
        } // if

        // interface with the workflow engine
        $workflow =& RDCsingleton::getInstance('workflow_engine');

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

        unset($workflow);

        return $this->errors;

    } // _examineWorkflow

    // ****************************************************************************
    function _examineWorkflowInstance ($where)
    // a task has just started, so ...
    // look to see if this task/context is a workitem within a workflow instance,
    // and if it is then set the appropriate variables (for use in finishWorkItem())
    {
        if (empty($where)) {
            return;  // no context yet, so ignore
        } // if

        $this->errors = array();

        // look for a workitem that matches this task_id and context
        $dbworkitem =& RDCsingleton::getInstance('wf_workitem');

        $context = addslashes(trim($where, ' ()'));
        //$workitem_where = "task_id='{$GLOBALS['task_id']}' AND context='$context'";
        // use 'LIKE' as the passed context may have been trimmed
        $workitem_where = "task_id='{$GLOBALS['task_id']}' AND context LIKE '$context%'";
//        if (isset($GLOBALS['batch']) AND is_True($GLOBALS['batch'])) {
//            $workitem_where .= " AND workitem_status='IP'"; // 'in progress'
//        } else {
//            $workitem_where .= " AND workitem_status='EN'"; // 'enabled'
//        } // if
        $workitem_where .= " AND workitem_status IN ('EN','IP')"; // 'in progress' or 'enabled'
        $workitem_data = $dbworkitem->getData($workitem_where);
        if ($dbworkitem->errors) {
            $this->errors = array_merge($this->errors, $dbworkitem->getErrors());
            return;
        } // if

        // if nothing found exit now
        if ($dbworkitem->numrows == 0) {
            unset($dbworkitem);
            return;
        } // if

        // use only first item
        reset($workitem_data);   // fix for version 4.4.1
        $workitem_data = $workitem_data[key($workitem_data)];

        if (isset($GLOBALS['batch']) AND is_True($GLOBALS['batch'] OR $workitem_data['workitem_status'] == 'IP')) {
            // ignore next check
        } else {
            // check that workitem has been assigned to this user's role
            if ($workitem_data['role_id'] != $_SESSION['role_id']) {
                //scriptPrevious("This task has been assigned to role " .$workitem_data['role_id']);
                $batch_errors = scriptPrevious($this->getLanguageText('sys0014', $workitem_data['role_id']));
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
                    $batch_errors = scriptPrevious($this->getLanguageText('sys0015', $workitem_data['user_id']));
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

        unset($dbworkitem);

        return;

    } // _examineWorkflowInstance

    // ****************************************************************************
    function _extract_custom_fields ($rowdata)
    // look for $rowdata['custom_fields']['field'] = array('name' => 'x', 'value' => 'y')
    // and extract entries to $rowdata['x'] => 'y'
    // this will make it easier to process any extra fields in subsequent code.
    {
        if (isset($rowdata['custom_fields']) AND isset($rowdata['custom_fields']['field'])) {
            if (is_string(key($rowdata['custom_fields']['field']))) {
                // only one entry, so set it to undex zero
                $array[] = $rowdata['custom_fields']['field'];
                $rowdata['custom_fields']['field'] = $array;
            } // if
            foreach ($rowdata['custom_fields']['field'] as $index => $data) {
                if (is_array($data)) {
                    if (array_key_exists('name', $data) AND array_key_exists('value', $data)) {
                        $rowdata[$data['name']] = $data['value'];
                    } // if
                } // if
            } // foreach
        } // if

        unset($rowdata['custom_fields']);  // values have been extracted, so this is now redundant

        return $rowdata;

    } // _extract_custom_fields

    // ****************************************************************************
    function _getCustomProcessingObject ()
    // look for an optional file containing code for custom processing.
    // this exists in the 'custom-processing' directory with a 'cp_' prefix.
    {
        if (empty($GLOBALS['project_code'])) {
            return;  // identity of subfolder not defined, so exit
        } // if

        $dirname = dirname($this->dirname) ."/classes/custom-processing/{$GLOBALS['project_code']}/";
        $fname = $dirname .'cp_' .get_class($this) .'.class.inc';
        if (file_exists($fname)) {
            // ** this code causes a hang in PHP 4 **
            //$class_name = "custom-processing/{$GLOBALS['project_code']}/cp_" .get_class($this);
            //$this->custom_processing_object =& RDCsingleton::getInstance($class_name);
            // include reference to calling object in the custom object
            //$this->custom_processing_object->calling_object =& $this;
            // **

            $class_name = 'cp_' .get_class($this);
            if (!class_exists($class_name)) {
                require_once($fname);
            } // if
            if (class_exists($class_name)) {
                $cpo = new $class_name;

                // make object variables available in custom object
                $cpo->dirname            =& $this->dirname;
                $cpo->dirname_dict       =& $this->dirname;
                $cpo->dbprefix           =& $this->dbprefix;
                $cpo->dbname             =& $this->dbname;
                $cpo->tablename          =& $this->tablename;
                $cpo->fieldspec          =& $this->fieldspec;
                $cpo->primary_key        =& $this->primary_key;
                $cpo->unique_keys        =& $this->unique_keys;
                $cpo->child_relations    =& $this->child_relations;
                $cpo->parent_relations   =& $this->parent_relations;
                $cpo->audit_logging      =& $this->audit_logging;
                $cpo->default_orderby    =& $this->default_orderby;
                $cpo->alt_language_table =& $this->alt_language_table;
                $cpo->alt_language_cols  =& $this->alt_language_cols;
                $cpo->nameof_start_date  =& $this->nameof_start_date;
                $cpo->nameof_end_date    =& $this->nameof_end_date;
                $cpo->sql_from           =& $this->sql_from;
                $cpo->sql_groupby        =& $this->sql_groupby;
                $cpo->sql_having         =& $this->sql_having;
                $cpo->sql_no_foreign_db  =& $this->sql_no_foreign_db;
                $cpo->sql_orderby        =& $this->sql_orderby;
                $cpo->sql_orderby_seq    =& $this->sql_orderby_seq;
                $cpo->sql_orderby_table  =& $this->sql_orderby_table;
                $cpo->sql_search         =& $this->sql_search;
                $cpo->sql_search_orig    =& $this->sql_search_orig;
                $cpo->sql_search_table   =& $this->sql_search_table;
                $cpo->sql_select         =& $this->sql_select;
                $cpo->sql_where          =& $this->sql_where;
                $cpo->sql_union          =& $this->sql_union;
                $cpo->initial_values     =& $this->initial_values;
                $cpo->lookup_data        =& $this->lookup_data;
                $cpo->rows_per_page      =& $this->rows_per_page;
                $cpo->pageno             =& $this->pageno;
                $cpo->numrows            =& $this->numrows;
                $cpo->initiated_from_controller =& $this->initiated_from_controller;
                $cpo->skip_getdata       =& $this->skip_getdata;
                $cpo->errors             =& $this->errors;
                $cpo->messages           =& $this->messages;
                $cpo->custom_replaces_standard =& $this->custom_replaces_standard;
                $cpo->zone               =& $this->zone;
                $cpo->no_display_count   =& $this->no_display_count;
                $cpo->unbuffered_query   =& $this->unbuffered_query;
                $cpo->xsl_params         =& $this->xsl_params;

                // include reference to calling object in the custom object
                $cpo->calling_object     =& $this;

                $this->custom_processing_object =& $cpo;
            } // if
        } // if

        return;

    } // _getCustomProcessingObject

    // ****************************************************************************
    function &_getDBMSengine ($dbname=null, $unbuffered_query=false)
    // obtain the object that deals with the database engine for this table.
    {
        $engine = null;
        $args   = array('dbname' => $dbname);

        if (!isset($GLOBALS['servers'])) {
            // single server option
            if (isset($GLOBALS['dbms'])) {
                $engine             =& $GLOBALS['dbms'];
            } // if
            if (isset($GLOBALS['dbhost'])) {
                $args['dbhost']     =& $GLOBALS['dbhost'];
            } // if
            if (isset($GLOBALS['dbusername'])) {
                $args['dbusername'] =& $GLOBALS['dbusername'];
            } // if
            if (isset($GLOBALS['dbuserpass'])) {
                $args['dbuserpass'] =& $GLOBALS['dbuserpass'];
            } // if
            if (isset($GLOBALS['dbport'])) {
                $args['dbport']     =& $GLOBALS['dbport'];
            } // if
            if (isset($GLOBALS['dbsocket'])) {
                $args['dbsocket']   =& $GLOBALS['dbsocket'];
            } // if
            if (isset($this->dbprefix)) {
                $args['dbprefix']   =& $this->dbprefix;
            } // if
            if (isset($GLOBALS['ssl_key'])) {
                $args['ssl_key']    =& $GLOBALS['ssl_key'];
            } // if
            if (isset($GLOBALS['ssl_cert'])) {
                $args['ssl_cert']   =& $GLOBALS['ssl_cert'];
            } // if
            if (isset($GLOBALS['ssl_ca'])) {
                $args['ssl_ca']     =& $GLOBALS['ssl_ca'];
            } // if
            if (isset($GLOBALS['ssl_capath'])) {
                $args['ssl_capath'] =& $GLOBALS['ssl_capath'];
            } // if
            if (isset($GLOBALS['ssl_cipher'])) {
                $args['ssl_cipher'] =& $GLOBALS['ssl_cipher'];
            } // if
            // these are options for non-MySQL databases
            if (isset($GLOBALS['PGSQL_dbname'])) {
                $args['PGSQL_dbname'] =& $GLOBALS['PGSQL_dbname'];
            } // if
            if (isset($GLOBALS['SQLSRV_schema'])) {
                $args['SQLSRV_schema'] =& $GLOBALS['SQLSRV_schema'];
            } // if
            if (isset($GLOBALS['serverName'])) {
                $args['serverName'] =& $GLOBALS['serverName'];
            } // if
            if (isset($GLOBALS['connectionInfo'])) {
                $args['connectionInfo'] =& $GLOBALS['connectionInfo'];
            } // if
        } else {
            // multi-server option
            // find out which server deals with this dbname
            foreach ($GLOBALS['servers'] as $servernum => $server) {
                if (empty($server['dbnames'])) {
                    // DBNAMES entry missing
                    trigger_error($this->getLanguageText('sys0170', 'DBNAMES'), E_USER_ERROR);
                } else {
                    $dbname_array = explode(',', $server['dbnames']);
                    $dbname_array = array_map('trim', $dbname_array);
                } // if
                if (!empty($server['switch_dbnames']) AND is_array($server['switch_dbnames'])) {
                    // database name in the class file may be switched to a different name on the server
                    $switch_dbnames = $server['switch_dbnames'];
                } else {
                    $switch_dbnames = array();
                } // if
                if ($server['dbnames'] == '*' OR in_array($dbname, $dbname_array) OR in_array($dbname, $switch_dbnames)) {
                    if (!isset($server['dbengine'])) {
                        trigger_error($this->getLanguageText('sys0170', 'DBENGINE'), E_USER_ERROR);
                    } else {
                        $engine = $server['dbengine'];
                    } // if
                    if (!isset($server['dbhost'])) {
                        trigger_error($this->getLanguageText('sys0170', 'DBHOST'), E_USER_ERROR);
                    } else {
                        $args['dbhost'] = $server['dbhost'];
                    } // if
                    if (!isset($server['dbusername'])) {
                        trigger_error($this->getLanguageText('sys0170', 'DBUSERNAME'), E_USER_ERROR);
                    } else {
                        $args['dbusername'] = $server['dbusername'];
                    } // if
                    if (!isset($server['dbuserpass'])) {
                        trigger_error($this->getLanguageText('sys0170', 'DBUSERPASS'), E_USER_ERROR);
                    } else {
                        $args['dbuserpass'] = $server['dbuserpass'];
                    } // if
                    if (!empty($server['dbport'])) {
                        $args['dbport'] = $server['dbport'];
                    } // if
                    if (!empty($server['dbsocket'])) {
                        $args['dbsocket'] = $server['dbsocket'];
                    } // if
                    if (!isset($server['dbprefix'])) {
                        trigger_error($this->getLanguageText('sys0170', 'DBPREFIX'), E_USER_ERROR);
                    } else {
                        $args['dbprefix'] = $server['dbprefix'];
                    } // if
                    if (!empty($server['ssl_key'])) {
                        $args['ssl_key'] = $server['ssl_key'];
                    } // if
                    if (!empty($server['ssl_cert'])) {
                        $args['ssl_cert'] = $server['ssl_cert'];
                    } // if
                    if (!empty($server['ssl_ca'])) {
                        $args['ssl_ca'] = $server['ssl_ca'];
                    } // if
                    if (!empty($server['ssl_capath'])) {
                        $args['ssl_capath'] = $server['ssl_capath'];
                    } // if
                    if (!empty($server['ssl_cipher'])) {
                        $args['ssl_cipher'] = $server['ssl_cipher'];
                    } // if
                    // these are options for non-MySQL databases
                    if (isset($server['PGSQL_dbname'])) {
                        $args['PGSQL_dbname'] =& $server['PGSQL_dbname'];
                    } // if
                    if (isset($server['SQLSRV_schema'])) {
                        $args['SQLSRV_schema'] =& $server['SQLSRV_schema'];
                    } // if
                    if (isset($server['serverName'])) {
                        $args['serverName'] =& $server['serverName'];
                    } // if
                    if (isset($server['connectionInfo'])) {
                        $args['connectionInfo'] =& $server['connectionInfo'];
                    } // if
                    break; // so stop here
                } // if
            } // foreach
            if (empty($engine)) {
                // "entry missing for database 'X'"
                trigger_error($this->getLanguageText('sys0171', $dbname), E_USER_ERROR);
            } // if
        } // if

        if (empty($engine)) {
            trigger_error("No value has been supplied for DBMS engine", E_USER_ERROR);
        } // if

        if (!class_exists($engine)) {
            // load class definition for this database engine
            if ($engine == 'mysql') {
                if (extension_loaded('mysqli')) {
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

        if (isset($servernum)) {
            $DML =& RDCsingleton::getInstance('server__' .$servernum .'__' .$engine, $args, true, $unbuffered_query);
        } else {
            $DML =& RDCsingleton::getInstance($engine, $args, true, $unbuffered_query);
        } // if

        return $DML;

    } // _getDBMSengine

    // ****************************************************************************
    function _getInitialValues ($task_id=null)
    // look for any initial values on the MNU_INITIAL_VALUE_USER table.
    // if none are found take a look on the MNU_INITIAL_VALUE_ROLE table.
    {
        $fieldarray = array();

        if (preg_match('/^(workflow|audit)$/i', $this->dbname)) {
            // ignore this code for those databases
            return $fieldarray;
        } // if

        $role_id = $_SESSION['role_id'];
        $user_id = $_SESSION['logon_user_id'];
        if (empty($task_id)) {
            if (!empty($GLOBALS['initial_values_task_id'])) {
                $task_id = $GLOBALS['initial_values_task_id'];
            } else {
                $task_id = $GLOBALS['task_id'];
            } // if
        } // if

        // look for ROLE data
        $dbobject =& RDCsingleton::getInstance('mnu_initial_value_role');
        $dbobject->sql_select = 'field_id, initial_value, is_noedit';
        $role_data = $dbobject->getData_raw("role_id='$role_id' AND task_id='$task_id'");
        unset($dbobject);
        foreach ($role_data as $rownum => $rowdata) {
            // change into an array which is keyed by field_id
            $field_id = strtolower($rowdata['field_id']);
            $init_data[$field_id]['initial_value'] = $rowdata['initial_value'];
            $init_data[$field_id]['is_noedit']     = $rowdata['is_noedit'];
        } // foreach

        // overwrite with USER data
        $dbobject =& RDCsingleton::getInstance('mnu_initial_value_user');
        $dbobject->sql_select = 'field_id, initial_value, is_noedit';
        $user_data = $dbobject->getData_raw("user_id='$user_id' AND task_id='$task_id'");
        unset($dbobject);
        foreach ($user_data as $rownum => $rowdata) {
            // change into an array which is keyed by field_id
            $field_id = strtolower($rowdata['field_id']);
            $init_data[$field_id]['initial_value'] = $rowdata['initial_value'];
            $init_data[$field_id]['is_noedit']     = $rowdata['is_noedit'];
        } // foreach

        if (!empty($init_data)) {
            // copy any values into this task's data area
            foreach ($init_data as $field_id => $field_data) {
                $fieldarray[$field_id] = $field_data['initial_value'];
                if (is_True($field_data['is_noedit'])) {
                    if (array_key_exists($field_id, $this->fieldspec)) {
                        // this field cannot be modified by the user
                        $this->fieldspec[$field_id]['noedit'] = 'y';
                    } // if
                } // if
            } // foreach
        } // if

        return $fieldarray;

    } // _getInitialValues

    // ****************************************************************************
    function _getInitialWhere ($where)
    // merge $this->initial_values with $where.
    {
        $fieldarray = where2array($where, false, false);

        if (!empty($this->initial_values)) {
            foreach ($this->initial_values as $key => $value) {
                if (empty($fieldarray[$key])) {
                    // current value is empty, so overwrite with initial value
                    $fieldarray[$key] = $value;
                } // if
            } // foreach
        } // if

        $where = array2where($fieldarray);

        return $where;

    } // _getInitialWhere

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
    function _qualify_dbname ($source_db, $target_db)
    // find out if the target database needs to be qualified - if it has been switched
    // (refer to _switch_databases() method) to the source database then it does not.
    {
        $dbprefix    = '';
        $dbms_engine = '';

        // use this function just in case the name has been switched in the config file.
        list($new_dbname, $dbprefix, $dbms_engine) = findDBConfig($target_db, $dbprefix, $dbms_engine);

        if ($new_dbname == $source_db) {
            // target dbname is the same, so does not need to be specified
            $output = '';
        } else {
            // target dbname needs to be specified and enclosed in double quotes
            $output = '"'.$dbprefix.$new_dbname.'".';
        } // if

        return $output;

    } // _qualify_dbname

    // ****************************************************************************
    function _sqlAssembleWhere ($where, $where_array)
    // assemble the $where clause from its component parts.
    // ($where = string, $where_array = array)
    {
        if (is_True($this->is_link_table)) {
            // this is for an outer-link-inner relationship
            $where = $this->_sqlAssembleWhereLink($where, $where_array);
        } else {
            if (isset($this->fieldspec['rdcaccount_id'])) {
                // this table is split by account, so account_id must be supplied in WHERE string
                if (empty($where_array['rdcaccount_id'])) {
                    if (!empty($_SESSION['rdcaccount_id'])) {
                        $account_id = $_SESSION['rdcaccount_id'];
                    } else {
                        $account_id = null;
                    } // if
                    if (empty($account_id) AND preg_match('/(mnu_user|mnu_account)/', $this->tablename)) {
                        // no account id supplied, so read everything on these tables only
                    } else {
                        if (empty($account_id) OR $account_id == 1) {
                            $account_id_string = "$this->tablename.rdcaccount_id='1'";
                        } else {
                            $account_id_string = "$this->tablename.rdcaccount_id IN ('1', '$account_id')";
                        } // if
                        if (empty($this->sql_search)) {
                            $this->sql_search = $account_id_string;
                        } else {
                            if (substr_count($this->sql_search, $account_id_string) == 0) {
                                $this->sql_search .= " AND $account_id_string";
                            } // if
                        } // if
                    } // if
                } // if
            } // if
        } // if

        if ($this->checkPrimaryKey or empty($this->sql_from) or ($this->sql_from == $this->tablename)) {
            // check that 'where' clause does not contain any fields that
            // are not in this table, otherwise it will cause an error
            $extra = array();
            if (is_object($this->custom_processing_object)) {
                if (method_exists($this->custom_processing_object, '_cm_filterWhere')) {
                    $extra = $this->custom_processing_object->_cm_filterWhere($extra);
                } // if
            } // if
            $extra = $this->_cm_filterWhere($extra);
            $where = filterWhere($where, $this->fieldspec, $this->tablename, $extra);
        } // if

        if (empty($this->sql_from)) {
            // obtain fields from foreign tables via a JOIN, if necessary
            $this->sql_from = $this->_sqlForeignJoin($this->sql_select, $this->sql_from, $this->parent_relations);
        } // if

        // remove any duplicated field names from the select string
        $this->sql_select = removeDuplicateFromSelect($this->sql_select);

        if (!empty($this->sql_search)) {
            // turn 'current/historic/future' into a range of dates
            $this->sql_search = $this->currentOrHistoric($this->sql_search, $this->nameof_start_date, $this->nameof_end_date);
            // check that 'search' clause does not contain any fields that
            // are not in this table, otherwise it will cause an error
            if (empty($this->sql_from) OR $this->sql_from == $this->tablename) {
                $extra = array();
                if (is_object($this->custom_processing_object)) {
                    if (method_exists($this->custom_processing_object, '_cm_filterWhere')) {
                        $extra = $this->custom_processing_object->_cm_filterWhere($extra);
                    } // if
                } // if
                $extra = $this->_cm_filterWhere($extra);
                $this->sql_search = filterWhere($this->sql_search, $this->fieldspec, $this->tablename, $extra);
            } // if
            // remove anything in $this->sql_search which is duplicated in $where
            $this->sql_search = filterWhere1Where2($where, $this->sql_search, $this->tablename);
        } // if

        // extract entries from $sql_select which are in format 'expression AS alias'
        $alias_array = extractAliasNames($this->sql_select);
        // anything in WHERE which has an alias name will be moved to HAVING
        $having_array = where2array($this->sql_having, false, false);

        if (empty($this->sql_from)) {
            $this->sql_from = $this->tablename;
        } // if

        // qualify each column name to avoid possible conflicts with other tables
        $where = qualifyWhere($where, $this->tablename, $this->fieldspec, $this->sql_from, null, $alias_array, $having_array);
        if (!empty($this->sql_where)) {
            if (preg_match('/^(AND |OR )/i', $this->sql_where)) {
                // begins with 'AND ' or 'OR ', so do not filter or qualify the contents
                $where .= ' '.$this->sql_where;
            } else {
                // temporarily remove anything in $this->sql_where which is duplicated in $where
                $sql_where = qualifyWhere($this->sql_where, $this->tablename, $this->fieldspec, $this->sql_from, null, $alias_array, $having_array);
                $sql_where = filterWhere1Where2($where, $sql_where, $this->tablename);
                if (!empty($sql_where)) {
                    // append optional 'sql_where' criteria to $where
                    if (!empty($where)) {
                        $where = mergeWhere($where, $sql_where);
                    } else {
                        $where = $sql_where;
                    } // if
                } // if
            } // if
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
                $this->sql_search = qualifyWhere($this->sql_search, $this->tablename, $this->fieldspec, $this->sql_from, $this->sql_search_table, $alias_array, $having_array);
                // merge $where with optional search criteria
                if (strlen(trim($this->sql_search)) > 0) {
                    if (empty($where)) {
                        $where = $this->sql_search;
                    } else {
                        $where = "($where) AND $this->sql_search";
                    } // if
                } // if
            } // if
        } // if

        // array may have been modified, so convert back into a string
        $this->sql_having = array2where($having_array);

        if (!empty($this->sql_from)) {
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
                    unset($dbobject);
                } else {
                    // look for 'original AS alias' in sql_from string
                    $alias_tablename = getTableAlias1($orderby_table, $this->sql_from);
                    if ($alias_tablename) {
                        require_once "classes/$alias_tablename.class.inc";
                        $dbobject  = new $alias_tablename;
                        $fieldspec = $dbobject->fieldspec;
                        unset($dbobject);
                    } else {
                        $fieldspec = array();
                    } // if
                } // if
            } else {
                $fieldspec = $this->fieldspec;
            } // if
            if (empty($this->sql_orderby)) {
                $this->sql_orderby = $this->default_orderby_task;
            } // if
            if (empty($this->sql_orderby)) {
                $this->sql_orderby = $this->default_orderby;
            } // if
            if (!empty($this->sql_orderby)) {
                if (is_True($this->is_link_table)) {
                    $this->sql_orderby = requalifyOrderby($this->sql_orderby, $this->sql_select, $this->tablename, $this->inner_table, $this->parent_relations);
                } else {
                    $this->sql_orderby = qualifyOrderby($this->sql_orderby, $orderby_table, $fieldspec, $this->sql_select, $this->sql_from);
                } // if
            } // if
        } // if

        return $where;

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
            $outer_link[]   = $outer_key[$ix] .'=' .$this->tablename .'.' .$fldchild;
        } // foreach

        if (!isset($this->inner_table)) {
            // if OUTER table is defined, then INNER must be as well
            trigger_error($this->getLanguageText('sys0011'), E_USER_ERROR); // 'Definition of INNER_TABLE is missing'
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
            $inner_link[]   = $inner_key[$ix] .'=' .$this->tablename .'.' .$fldchild;
        } // foreach

        $this->link_item = $this->tablename .'.' .$fldchild;

        // assemble the sql SELECT clause
        if (strlen($this->sql_select) > 0) {
            $sql_select = $this->sql_select .', ';
        } else {
            $sql_select = '';
        } // if
        foreach ($outer_key_as as $field) {
            $sql_select .= $field .', ';
        } // foreach
        foreach ($inner_key_as as $field) {
            $sql_select .= $field .', ';
        } // foreach
        $sql_select = rtrim($sql_select, ', ');  // remove trailing comma

        // include field from parent entity, if defined
        if (isset($reldata['parent_field'])) {
            if (substr_count($reldata['parent_field'], '(') > 0) {
                // field contains 'function(...)', so do not qualify it with table name
                $sql_select .= ', ' .$reldata['parent_field'];
            } else {
                // fieldname to be qualified with either table or alias name
                if (isset($reldata['alias'])) {
                    $sql_select .= ', ' .$reldata['alias'] .'.' .$reldata['parent_field'];
                } else {
                    $sql_select .= ', ' .$reldata['parent'] .'.' .$reldata['parent_field'];
                } // if
            } // if
        } // if

        $sql_select .= ", CASE WHEN $this->link_item IS NULL THEN 'F' ELSE 'T' END AS selected";

        // assemble the sql FROM clause
        $sql_from   = $outer_table .' CROSS JOIN ';
        if (empty($inner_alias)) {
            $sql_from .= $inner_table;
        } else {
            $sql_from .= $inner_table .' AS ' .$inner_alias;
        } // if

        // find out if the inner table contains the 'account_id' column
        $dbobject =& RDCsingleton::getInstance($inner_table, null, false);
        if (isset($dbobject->fieldspec['rdcaccount_id'])) {
            if (empty($inner_alias)) {
                $account_id_string = $inner_table;
            } else {
                $account_id_string = $inner_alias;
            } // if
            $account_id =& $_SESSION['rdcaccount_id'];
            if (empty($account_id)) {
                $account_id_string .= ".rdcaccount_id='1'";
            } else {
                $account_id_string .= ".rdcaccount_id IN ('1', '$account_id')";
            } // if
            $sql_from .= " ON ($account_id_string)";
        } // if
        unset($dbobject);

        $sql_from  .= ' LEFT JOIN ' .$this->tablename .' ON (';
        foreach ($outer_link as $link) {
            $sql_from .= $link .' AND ';
        } // foreach
        foreach ($inner_link as $link) {
            $sql_from .= $link .' AND ';
        } // foreach
        // remove last 5 characters (' AND ')
        $sql_from = substr($sql_from, 0, strlen($sql_from) - 5);
        $sql_from .= ') ';

        if (!empty($reldata['alt_language_table'])) {
            $party_language = str_replace('_', '-', strtolower($GLOBALS['party_language']));
            if ($party_language != $_SESSION['default_language']) {
                // link to table which provides text in an alternative language
                $pkey_array = $reldata['fields'];
                $new_relation = array('parent' => $reldata['alt_language_table'],
                                      'parent_field' => $reldata['alt_language_cols'],
                                      'fields' => $pkey_array);
                $new_relation['this'] = $inner_table;
                $sql_select = $this->_sqlSelectAlternateLanguage($sql_select, $new_relation);
            } // if
        } // if

        $this->sql_select = $sql_select;
        $this->sql_from   = $sql_from .' ' .$this->sql_from;

        return $where;

    } // _sqlAssembleWhereLink

    // ****************************************************************************
    function _sqlForeignJoin (&$select, $from, $parent_relations)
    // if there are parent relations then construct a JOIN.
    // Note that $select is passed by reference as it may be amended.
    {
        if (empty($parent_relations) AND empty($this->alt_language_table)) {
            if (empty($select)) {
                $select = $this->tablename .'.*';
            } // if
            if (empty($from)) {
                $from = $this->tablename;
            } // if
            return $from;
        } // if

        if (empty($select)) {
            if (empty($this->alt_language_table)) {
                $select = $this->tablename .'.*';
            } else {
                // insert 'table.field' into SELECT for every field in this table
                foreach ($this->fieldspec as $fieldname => $fieldspec) {
                    if (array_key_exists('nondb', $fieldspec)) {
                        // this is a non-database field, so ignore it
                    } else {
                        if (empty($select)) {
                            $select = $this->tablename .'.' .$fieldname;
                        } else {
                            $select .= ', ' .$this->tablename .'.' .$fieldname;
                        } // if
                    } // if
                } // foreach
            } // if
        } else {
            $select = qualifySelect($select, $this->tablename, $this->fieldspec);
        } // if

        if (empty($from)) {
            $from = $this->tablename;
        } // if

        $alt_language_relations = array();
        if (!empty($this->alt_language_table)) {
            $party_language = str_replace('_', '-', strtolower($GLOBALS['party_language']));
            if ($party_language != $_SESSION['default_language']) {
                // add in a new relation for the alternative language table
                $pkey_array = array();
                foreach ($this->primary_key as $fieldname) {
                    $pkey_array[$fieldname] = $fieldname;
                } // foreach
                $temp_relation = array('parent' => $this->alt_language_table,
                                       'parent_field' => $this->alt_language_cols,
                                       'fields' => $pkey_array);
                $temp_relation['this'] = $this->tablename;
                $alt_language_relations[] = $temp_relation;
            } // if
        } // if

        foreach ($parent_relations as $reldata) {
            if (!isset($reldata['parent_field'])) {
                // parent_field is not defined, so ignore this entry
            } else {
                $reldata['this'] = $this->tablename;
                $from = $this->_sqlProcessJoin ($select, $from, $reldata, $alt_language_relations);
            } // if
        } // foreach

        foreach ($alt_language_relations as $reldata) {
            $select = $this->_sqlSelectAlternateLanguage($select, $reldata);
        } // foreach

        return $from;

    } // _sqlForeignJoin

    // ****************************************************************************
    function _sqlProcessJoin (&$select, $from, $reldata, &$new_relations)
    // construct a JOIN using relationship details in $reldata.
    // Note that $select is passed by reference as it may be amended.
    // Note that $new_relations is passed by reference as it may be amended.
    {
        $parent_table = $reldata['parent'];
        $parent_field = $reldata['parent_field'];

        // does this belong to another database/schema?
        if (isset($reldata['dbname'])) {
            if (is_True($this->sql_no_foreign_db)) {
                // do NOT join to tables in different database
                return $from;
            } // if
        } // if

        // does this table have an alias?
        if (isset($reldata['alias'])) {
            $parent_alias = $reldata['alias'];
        } else {
            $parent_alias = '';
        } // if

        // obtain $fieldspec array for relevant table ($this or another)
        if ($parent_table != $reldata['this']) {
            // instantiate an object for this table
            if (array_key_exists('subsys_dir', $reldata)) {
                // get path to current subsystem directory
                $dir = dirname($this->dirname);
                // switch to other subsystem directory
                $dir = dirname($dir) .'/' .$reldata['subsys_dir'] .'/';
            } else {
                $dir = NULL;
            } // if
            if (!class_exists($parent_table)) {
                require_once $dir ."classes/$parent_table.class.inc";
            } // if
            $parentObj = new $parent_table;
            if (isset($reldata['dbname'])) {
                if ($parentObj->dbname == $this->dbname AND $parentObj->dbprefix == $this->dbprefix) {
                    // original values have been overridden in the config file, so now there is no
                    // difference in the database name, so no qualification is necessary
                    $dbname = '';
                } else {
                    // enclose $dbname in quotes to deal with non-standard characters
                    $dbname = '"' .$parentObj->dbprefix .$parentObj->dbname .'"' .'.';
                } // if
            } else {
                $dbname = '';
            } // if
            $fieldspec   = $parentObj->fieldspec;
            $primary_key = $parentObj->primary_key;
            if (empty($reldata['alt_language_cols']) AND !empty($parentObj->alt_language_cols)) {
                $reldata['alt_language_table'] = $parentObj->alt_language_table;
                $reldata['alt_language_cols']  = $parentObj->alt_language_cols;
            } // if
            unset($parentObj);
        } else {
            $dbname      = '';
            $fieldspec   = $this->fieldspec;
            $primary_key = $this->primary_key;
        } // if

        if (!empty($reldata['alt_language_cols'])) {
            // find out if any column names have an alias
            $parent_array = extractFieldNamesAssoc($parent_field);
            $alt_array    = extractFieldNamesAssoc($reldata['alt_language_cols']);
            $alt_cols     = '';
            foreach ($parent_array as $field_alias => $fieldname) {
                if (array_key_exists($fieldname, $alt_array)) {
                    if ($field_alias != $fieldname) {
                        $string = $fieldname .' AS ' .$field_alias;
                    } else {
                        $string = $fieldname;
                    } // if
                    if (empty($alt_cols)) {
                        $alt_cols = $string;
                    } else {
                        $alt_cols .= ', ' .$string;
                    } // if
                } // if
            } // foreach
            $reldata['alt_language_cols'] = $alt_cols;
        } // if

        // get list of alias names used in current SELECT list
        $select_aliases = extractAliasNames($select);
        if (!empty($select_aliases)) {
            // find out if any new field has an alias name
            $parent_field_array = extractSelectList($parent_field);
            foreach ($parent_field_array as $key => $field) {
                list($fld_orig, $fld_alias) = getFieldAlias3($field);
                if ($fld_orig != $fld_alias) {
                    while (array_key_exists($fld_alias, $select_aliases)) {
                        // this alias name is already used, so append an 'x' to make it unique
                        $fld_alias .= 'x';
                    } // while
                    $field = $fld_orig .' AS ' .$fld_alias;
                    $parent_field_array[$key] = $field;
                } // if
            } // foreach
            $parent_field = implode(', ', $parent_field_array);
        } // if

        // put parent field(s) from foreign table into SELECT area
        if (!empty($parent_alias)) {
            $parent_field = qualifySelect($parent_field, $parent_alias, $fieldspec);
        } else {
            $parent_field = qualifySelect($parent_field, $parent_table, $fieldspec);
        } // if
        $select .= ', ' .$parent_field;

        // build JOIN using supplied field names
        if (!empty($parent_alias)) {
            $from .= ' LEFT JOIN ' .$dbname .$reldata['parent']  .' AS ' .$parent_alias .' ON (';
        } else {
            $from .= ' LEFT JOIN ' .$dbname .$reldata['parent']  .' ON (';
        } // if
        foreach ($reldata['fields'] as $fldchild => $fldparent) {
            //if (strlen($fldchild) < 1) {
            //    // 'Name of child field missing in relationship with $parent_table'
            //    trigger_error($this->getLanguageText('sys0110', strtoupper($parent_table)), E_USER_ERROR);
            //} // if
            if (strlen($fldparent) < 1) {
                // 'Name of parent field missing in relationship with $parent_table'
                trigger_error($this->getLanguageText('sys0112', strtoupper($parent_table)), E_USER_ERROR);
            } // if
            if (!empty($fldchild)) {
                if (!empty($parent_alias)) {
                    $from .= $parent_alias .'.' .$fldparent .'=' .$reldata['this'] .'.' .$fldchild .' AND ';
                } else {
                    $from .= $parent_table .'.' .$fldparent .'=' .$reldata['this'] .'.' .$fldchild .' AND ';
                } // if
            } // if
        } // foreach
        // remove last 5 characters (' AND ')
        $from = substr($from, 0, strlen($from) - 5);
        $from .= ')';

        if (!empty($reldata['alt_language_table'])) {
            $party_language = str_replace('_', '-', strtolower($GLOBALS['party_language']));
            if ($party_language != $_SESSION['default_language']) {
                // add in a new relation for the alternative language table
                $pkey_array = array();
                foreach ($primary_key as $fieldname) {
                    $pkey_array[$fieldname] = $fieldname;
                } // foreach
                $temp_relation = array('parent' => $reldata['alt_language_table'],
                                       'parent_field' => $reldata['alt_language_cols'],
                                       'fields' => $pkey_array);
                if (isset($reldata['alias'])) {
                    $temp_relation['this'] = $reldata['alias'];
                } else {
                    $temp_relation['this'] = $reldata['parent'];
                } // if
                if (isset($reldata['dbname'])) {
                    $temp_relation['dbname'] = $reldata['dbname'];
                } // if
                $new_relations[] = $temp_relation;
            } // if
        } // if

        return $from;

    } // _sqlProcessJoin

    // ****************************************************************************
    function _sqlSelectAlternateLanguage ($sql_select, $reldata, $subquery=false)
    // insert SELECT clause to obtain text from an alternative language table,
    // (or the orginal text if alternative text is not found).
    // if $subquery=true it means $fldchild was obtained from a subquery and need
    // not be qualified with a table name.
    {
        // convert underscore to hyphen for database lookup
        $party_language = str_replace('_', '-', strtolower($GLOBALS['party_language']));

        list($this_table_orig, $this_table_alias) = getTableAlias3($reldata['this']);
        if (empty($this_table_alias)) {
            $this_table_orig = $reldata['this'];
            $this_table_alias = $this_table_orig;
        } // if

        // extract all elements within current SELECT clause into an associative array
        $select_array = extractSelectList($sql_select);

        // look for names which have an alias
        $select_alias = extractFieldNamesAssoc($select_array);

        // create an array of field names (and possible alias names) which are to be added
        $field_array = extractFieldNamesAssoc($reldata['parent_field']);

        // each field requires a separate sub-select
        foreach ($field_array as $field_alias => $field_name) {
            if ($field_alias == $field_name) {
                // check for alias name in $sql_select
                $test = array_search($field_name, $select_alias);
                if (empty($test)) {
                    // try using with a qualified name
                    $test = array_search("$this_table_alias.$field_name", $select_alias);
                    if ($test == $select_alias[$test]) {
                        // this is not a different value, so it is not an alias
                        $test = null;
                    } // if
                } // if
                if (!empty($test)) {
                    $field_alias = $test;
                } // if
            } // if

            // remove any previous element which uses this name
            if ($this_table_orig == $this_table_alias) {
                $select_array = removeDuplicateNameFromSelect($select_array, $field_alias);
            } elseif ($field_name != $field_alias) {
                $select_array = removeDuplicateNameFromSelect($select_array, $field_alias);
            } else {
                $select_array = removeDuplicateNameFromSelect($select_array, "$this_table_alias.$field_alias");
            } // if

            // build new element for SELECT clause
            $string  = "\nCOALESCE((SELECT $field_name FROM ";
            if (isset($reldata['dbname'])) {
                list($dbname, $dbprefix, $dbms_engine) = findDBConfig($reldata['dbname'], $this->dbprefix, $this->dbms_engine);
                $string .= '"' .$dbprefix .$dbname .'".';
            } // if
            $string .= "{$reldata['parent']} WHERE ";
            foreach ($reldata['fields'] as $fldchild => $fldparent) {
                if ($subquery == true) {
                    // field obtained from a subquery, so do not qualify it
                    $string .= "{$reldata['parent']}.$fldparent=$fldchild AND ";
                } elseif (strpos($fldchild, '.') === false) {
                    // qualify $fldchild with this tablename
                    $string .= "{$reldata['parent']}.$fldparent=$this_table_alias.$fldchild AND ";
                } else {
                    // $fldchild is already qualified, so use it 'as is'
                    $string .= "{$reldata['parent']}.$fldparent=$fldchild AND ";
                } // if
            } // foreach
            $string .= "{$reldata['parent']}.language_id='$party_language'";
            if ($subquery == true) {
                $string .= "), (SELECT $field_name FROM ";
                if (isset($reldata['dbname'])) {
                    $string .= '"' .$this->dbprefix .$reldata['dbname'] .'".';
                } // if
                $string .= "$this_table_orig WHERE ";
                foreach ($reldata['fields'] as $fldchild => $fldparent) {
                    $string .= "$this_table_orig.$fldparent=$fldchild AND ";
                } // foreach
                // remove final ' AND '
                $string = substr($string, 0, -5);
                $string .= ")";
            } else {
                $string .= "), $this_table_alias.$field_name";
            } // if
            $string .= ") AS $field_alias";

            // append to current SELECT clause
            $select_array[] = $string;
        } // foreach

        // convert array back into a string
        $sql_select = implode(', ', $select_array);

        return $sql_select;

    } // _sqlSelectAlternateLanguage

    // ****************************************************************************
    function _switch_database ($tablename, $dbname)
    // create an instance of a table class and switch the database name.
    // $dbname will be different from the one inside the table class.
    {
        if (!class_exists($tablename)) {
            require_once("$tablename.class.inc");
        } // if

        $dbobject = new $tablename();

        $dbname_old = $dbobject->dbname;

        // use this function just in case the name has been switched in the config file.
        list($dbobject->dbname, $dbprefix, $dbms_engine) = findDBConfig($dbname, $dbobject->dbprefix, $dbobject->dbms_engine);

        // save the original dbname in case we have to delete child relations
        $dbobject->dbname_old = $dbname_old;

        return $dbobject;

    } // _switch_database

    // ****************************************************************************
    function _validateInsert ($fieldarray)
    // validate contents of $fieldarray prior to an INSERT
    {
        $validationobj =& RDCsingleton::getInstance('validation_class');

        $array = $validationobj->validateInsert($fieldarray, $this->fieldspec, $this);

        $this->errors = $validationobj->getErrors();

        return $array;

    } // _validateInsert

    // ****************************************************************************
    function _validateUpdate ($fieldarray)
    // validate contents of $fieldarray prior to an UPDATE
    {
        $validationobj =& RDCsingleton::getInstance('validation_class');

        $array = $validationobj->validateUpdate($fieldarray, $this->fieldspec, $this);

        $this->errors = $validationobj->getErrors();

        return $array;

    } // _validateUpdate

    // ****************************************************************************
    function __call ($method, $arguments)
    // magic method to satisfy method names which are not defined in a standard object,
    // but which may be defined in a custom object.
    {
        if (is_object($this->custom_processing_object)) {
            if (method_exists($this->custom_processing_object, $method)) {
                $result = $this->custom_processing_object->$method($arguments[0]);
            } else {
                trigger_error("Method '$method' does not exist in custom object", E_USER_ERROR);
            } // if
        } else {
            trigger_error("Method '$method' does not exist in standard object", E_USER_ERROR);
        } // if

        return $result;

    } // __call

    // ****************************************************************************
    function __sleep ()
    // perform object clean-up before serialization
    {
        // this causes an endless loop
//        if (is_object(($this->custom_processing_object))) {
//            $this->custom_processing_object_serial = serialize($this->custom_processing_object);
//            unset($this->custom_processing_object);
//        } // if

        // get associative array of class variables
        $object_vars = get_object_vars($this);

        // remove/clear unwanted variables
        $object_vars['errors'] = array();
        $object_vars['messages'] = array();

        // convert to indexed array
        $object_vars = array_keys($object_vars);

        return $object_vars;

    } // __sleep

    // ****************************************************************************
    function __wakeup ()
    // perform object initialisation after unserialization
    {
        // look for custom processing object
        $this->_getCustomProcessingObject();

    } // __wakeup

// ****************************************************************************
} // end class
// ****************************************************************************

?>
