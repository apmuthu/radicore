<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2010 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.add5.inc

// type = add5

// This will display data from 2 tables in a ONE-to-MANY relationship.
// (also known as a PARENT-CHILD or OUTER-INNER relationship).
// It will start by reading the OUTER entity using the primary key passed down
// from the previous screen, then show a number of blank occurrences of INNER.
// On SUBMIT all occurrences of INNER will be added to the database.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'insert';

// load session variables
initSession();

$original_where     = $where;
$original_selection = $selection;
//if (!empty($selection) AND !isset($return_from)) {
//	if (empty($where)) {
//    	// only use $selection if $where is empty
//        $where = $selection;
//        $selection = null;
//    } // if
//} // if

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
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $dbouter->restart($return_from, $return_action);
    } // if
    // get data from previous instance
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
    $where = $dbouter->initialise($original_where, $original_selection);
    if ($dbouter->errors) {
        scriptPrevious($dbouter->getErrors());
    } // if
} // if

// create a class instance for the INNER database table
require_once "classes/$inner_table.class.inc";
if (isset($script_vars['dbinner'])) {
    // use data from previous instance of this script
    $dbinner = unserialize($script_vars['dbinner']);
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $dbinner->restart($return_from, $return_action);
    } // if
    // get data from previous instance
    $inner_data = $dbinner->getFieldArray();
} else {
    $dbinner = new $inner_table;
    // indicate that this object was started from a page controller
    $dbinner->initiated_from_controller = true;
    $dbinner->rows_per_page          = 0;   // turn off pagination
    $dbinner->xsl_params['noshow']   = 'y'; // turn off page size selection
    $dbinner->xsl_params['noselect'] = 'y'; // turn off row selection
    // perform any initialisation
    $null = $dbinner->initialise($original_where, $original_selection);
    if ($dbinner->errors) {
        scriptPrevious($dbinner->getErrors());
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
    if (empty($errors)) {
	    // look for a custom button (a field which begins with 'button#')
	    $button = false;
        foreach ($_POST as $postname => $postvalue) {
        	if (preg_match('/^button#/i', $postname, $regs)) {
        	    // strip off the prefix to leave the original field name
        		$button = str_replace($regs[0], '', $postname);
        		break;
        	} // if
        } // foreach
        if ($button) {
        	// a custom button was pressed - was it for outer or inner entity?
        	if (is_array($postvalue)) {
        		$row = key($postvalue)-1;
        		$inner_data = $dbinner->customButton($inner_data[$row], $button, $row);
        		if ($dbinner->errors) {
                    // errors are keyed by object name
                    $errors[$dbinner->getClassName()] = $dbinner->getErrors();
                } // if
        	} else {
        	    $outer_data = $dbouter->customButton($outer_data, $button);
        	    if ($dbouter->errors) {
                    // errors are keyed by object name
                    $errors[$dbouter->getClassName()] = $dbouter->getErrors();
                } // if
        	} // if
        } // if
    } // if
} // if

// look for entered data
if (isset($_POST['submit']) or isset($_POST['submitstay'])) {
    $dbinner->startTransaction();
    $outer_data = $dbouter->updateRecord($outer_data);
    if ($dbouter->errors) {
        // errors are keyed by object name
        $errors[$dbouter->getClassName()] = $dbouter->getErrors();
    } else {
        // update of $outer was OK, so update $inner as well
        $inner_data = $dbinner->insertMultiple($inner_data);
        if ($dbinner->errors) {
            // errors are keyed by object name
            $errors[$dbinner->getClassName()] = $dbinner->getErrors();
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
} // if

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    // check to see if we are returning from a child form
    if (!empty($return_from) AND !empty($popup_object)) {
        if (isset($selection) AND $popup_object == 'dbouter') {
            // merge previous saved variables with selection from popup form
            $outer_data = $dbouter->popupReturn($outer_data, basename($return_from), $selection, $popup_offset);
            if ($dbouter->errors) {
            	$errors[$dbouter->getClassName()] = $dbouter->getErrors();
            } // if
            // make any changes in outer available to the inner entity
            $inner_data = $dbinner->setParentData($outer_data);
        } // if
    } else {
        // get data from the outer table
        $outer_data = $dbouter->getData($where);
        if ($dbouter->errors) {
            // some sort of error
            scriptprevious($dbouter->getErrors(), $messages);
        } // if
        if ($dbouter->getNumRows() < 1) {
            scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
        } // if

        // get any additional data for the current record
        $outer_data = $dbouter->getExtraData($outer_data);
        if ($dbouter->errors) {
        	$errors[$dbouter->getClassName()] = $dbouter->getErrors();
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
                $errors[$dbinner->getClassName()] = $dbinner->getErrors();
            } // if

            if ($dbinner->getNumRows() == 0) {
                $errors[] = getLanguageText('sys0088', strtoupper($inner_table)); // 'No entries found on $inner_table'
                unset($act_buttons['submit']);
            } // if

            // get any additional data for current record
            $inner_data = $dbinner->getExtraData($inner_data);
            if ($dbinner->errors) {
            	$errors[$dbinner->getClassName()] = $dbinner->getErrors();
            } // if
        } // if

        if ($dbinner->errors) {
        	$errors[$dbinner->getClassName()] = $dbinner->getErrors();
        } // if
    } // if
} // if

// save these variables for later in the same session
$script_vars['where']     = unqualifyWhere($where);
$script_vars['dbouter']   = serialize($dbouter);
$script_vars['dbinner']   = serialize($dbinner);
$script_vars = updateScriptVars ($script_vars);

if ($_SERVER['REQUEST_METHOD'] == 'POST' AND empty($errors) AND !$button) {
    // repeat current task with GET instead of POST
    scriptNext($GLOBALS['task_id'], $where);
} // if

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbouter;
$xml_objects[][$dbouter->getClassName()] = &$dbinner;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);
exit;

?>