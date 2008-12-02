<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2008 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.add5.inc

// type = add5

// This will display data from 2 tables in a ONE-to-MANY relationship.
// (also known as a PARENT-CHILD or OUTER-INNER retaltionship).
// It will start by reading the OUTER entity using the primary key passed down
// from the previous screen, then show a number of blank occurrences of INNER.
// On SUBMIT all occurrences of INNER will be added to the database.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'insert';

// load session variables
initSession();

if (!empty($selection) AND !isset($return_from)) {
	if (empty($where)) {
    	// only use $selection if $where is empty
        $where = $selection;
        $selection = null;
    } // if
} // if

if (isset($_POST['quit'])) {
    // clear this script from session details and return to previous page
    scriptPrevious(null, null, 'quit');
} // if

// define action buttons
$act_buttons['submit']     = 'submit';
$act_buttons['submitstay'] = 'submitstay';
$act_buttons['quit']       = 'cancel';

// create a class instance for the OUTER database table
require_once "classes/$outer_table.class.inc";
if (isset($script_vars['dbouter'])) {
    // use data from previous instance of this script
    $dbouter = unserialize($script_vars['dbouter']);
    // get previously retrieved data
    $outer_data = $dbouter->getFieldArray();
    if (!is_string(key($outer_data))) {
        // indexed by row, so use row zero only
        $outer_data = $outer_data[key($outer_data)];
    } // if
} else {
    // create new instance for initial activation of this script
    $dbouter = new $outer_table;
    // indicate that this object was started from a page controller
    $dbouter->initiated_from_controller = true;
    $dbouter->sql_select     = &$outer_sql_select;
    $dbouter->sql_from       = &$outer_sql_from;
    $dbouter->sql_where      = &$outer_sql_where;
    $dbouter->sql_groupby    = &$outer_sql_groupby;
    $dbouter->sql_having     = &$outer_sql_having;
    // scroll through one item at a time
    $dbouter->setRowsPerPage(1);
    // check that primary key is complete
    $dbouter->checkPrimaryKey = true;
    // perform any initialisation
    $where = $dbouter->initialise($where, $selection);
    if ($dbouter->errors) {
        scriptPrevious($dbouter->errors);
    } // if
} // if

// create a class instance for the INNER database table
require_once "classes/$inner_table.class.inc";
if (isset($script_vars['dbinner'])) {
    // use data from previous instance of this script
    $dbinner = unserialize($script_vars['dbinner']);
    // get previously retrieved data
    $inner_data = $dbinner->getFieldArray();
} else {
    $dbinner = new $inner_table;
    // indicate that this object was started from a page controller
    $dbinner->initiated_from_controller = true;
    $dbinner->rows_per_page          = 0;   // turn off pagination
    $dbinner->xsl_params['noshow']   = 'y'; // turn off page size selection
    $dbinner->xsl_params['noselect'] = 'y'; // turn off row selection
    // perform any initialisation
    $null = $dbinner->initialise($where);
    if ($dbinner->errors) {
        scriptPrevious($dbinner->errors);
    } // if
} // if

if (!empty($_POST)) {
    // merge original data with POSTed data (so that fields which were displayed
    // but not POSTed are sent back if any errors are displayed).
    $outer_post = getPostArray($_POST, $dbouter->getFieldSpec());
    $outer_data = array_update_associative($outer_data, $outer_post);
    $dbouter->setFieldArray($outer_data);
    // repeat for the inner entity
    $inner_post = getPostArray($_POST, $dbinner->getFieldSpec());
    $inner_data = array_update_indexed($inner_data, $inner_post);
    $dbinner->setFieldArray($inner_data);
    // make any changes in outer available to the inner entity
    $inner_data = $dbinner->setParentData($outer_data);
    // look for an action which is another script
    $errors = childForm($_POST, array('dbouter' => &$dbouter, 'dbinner' => &$dbinner));
} // if

// look for entered data
if (isset($_POST['submit']) or isset($_POST['submitstay'])) {
    $dbinner->startTransaction();
    $outer_data = $dbouter->updateRecord($outer_data);
    if ($dbouter->errors) {
        // errors are keyed by object name
        $errors[$dbouter->getClassName()] = $dbouter->errors;
    } else {
        $inner_data = $dbinner->insertMultiple($inner_data);
        if ($dbinner->errors) {
            // errors are keyed by object name
            $errors[$dbinner->getClassName()] = $dbinner->errors;
        } // if
    } // if
    if ($errors) {
        $dbinner->rollback();
    } else {
        // update was OK
        $dbinner->wf_case_id     = $dbouter->wf_case_id;
        $dbinner->wf_workitem_id = $dbouter->wf_workitem_id;
        $dbinner->wf_context     = $dbouter->wf_context;
        $errors = $dbinner->commit();
        if ($errors) {
        	$dbinner->rollback();
        } else {
            $messages = $dbinner->getMessages();
            if (isset($_POST['submitstay'])) {
                // re-initialise data for a new record
                $inner_data = $dbinner->getInitialDataMultiple($outer_data);
                // deal with any data from the parent object
                $inner_data = $dbinner->setParentData($outer_data);
                // get any extra data and merge with $inner_data
                $inner_data = $dbinner->getExtraData($inner_data);
            } else {
                // update was OK - return to previous screen
                scriptPrevious($errors, $messages, 'OK', $dbinner->getInstruction());
            } // if
        } // if
    } // if
} else {

    // check if we are returning from a child form
    if (!empty($return_from) AND !empty($popup_object)) {
        if (isset($selection) AND $popup_object == 'dbouter') {
            // merge previous saved variables with selection from popup form
            $outer_data = $dbouter->popupReturn($outer_data, basename($return_from), $selection, $popup_offset);
            if ($dbouter->errors) {
            	$errors[$dbouter->getClassName()] = $dbouter->errors;
            } // if
            // make any changes in outer available to the inner entity
            $inner_data = $dbinner->setParentData($outer_data);
        } // if
    } else {
        // get data from the outer table
        $outer_data = $dbouter->getData($where);
        if ($dbouter->errors) {
            // some sort of error
            scriptprevious($dbouter->errors, $messages);
        } // if
        if ($dbouter->getNumRows() < 1) {
            scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
        } // if

        // get any additional data for the current record
        $outer_data = $dbouter->getExtraData($outer_data);
        if ($dbouter->errors) {
        	$errors[$dbouter->getClassName()] = $dbouter->errors;
        } // if

        // save these variables for later in the same session in case INNER performs a scriptNext()
        $script_vars['where']     = unqualifyWhere($where);
        $script_vars['dbouter']   = serialize($dbouter);
        $script_vars = updateScriptVars ($script_vars);
    } // if

    // only procss INNER if OUTER is not empty
    if (count($outer_data) > 0) {
        if (!empty($return_from) AND !empty($popup_object)) {
            if (isset($selection) AND $popup_object == 'dbinner') {
                $inner_data = $dbinner->popupReturn($inner_data, basename($return_from), $selection, $popup_offset);
            } //if
        } else {
            if (empty($dbinner->errors)) {
                // no errors, so get initial data
                $inner_data = $dbinner->getInitialDataMultiple($outer_data);
                $dbinner->numrows = count($inner_data);
            } // if
            if ($dbinner->errors) {
                $errors[$dbinner->getClassName()] = $dbinner->errors;
            } // if

            if ($dbinner->getNumRows() == 0) {
                $errors[] = getLanguageText('sys0088', strtoupper($inner_table)); // 'No entries found on $inner_table'
                unset($act_buttons['submit']);
            } // if

            // get any additional data for current record
            $inner_data = $dbinner->getExtraData($inner_data);
            if ($dbinner->errors) {
            	$errors[$dbinner->getClassName()] = $dbinner->errors;
            } // if
        } // if

        if ($dbinner->errors) {
        	$errors[$dbinner->getClassName()] = $dbinner->errors;
        } // if
    } // if
} // if

// save these variables for later in the same session
$script_vars['where']     = unqualifyWhere($where);
$script_vars['dbouter']   = serialize($dbouter);
$script_vars['dbinner']   = serialize($dbinner);
$script_vars = updateScriptVars ($script_vars);

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbouter;
$xml_objects[][$dbouter->getClassName()] = &$dbinner;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);
exit;

?>
