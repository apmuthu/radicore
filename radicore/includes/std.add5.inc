<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
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
$act_buttons['submitBtn']  = 'submit';  // do not use name 'submit' as this conflicts with javascript 'submit()' function.
$act_buttons['submitstay'] = 'submitstay';
$act_buttons['quit']       = 'cancel';

// create a class instance for the OUTER database table
require_once "classes/$outer_table.class.inc";
if (isset($script_vars['dbouter'])) {
    // use data from previous instance of this script
    $dbouter = unserialize($script_vars['dbouter']);
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $dbouter->restart($return_from, $return_action, $return_string, $return_files);
    } // if
    // get data from previous instance
    $outer_data = $dbouter->getFieldArray();
    // get any extra data and merge with $fieldarray
    $outer_data = $dbouter->getExtraData($outer_data);
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
    $dbouter->initiated_from_controller = true;
    $dbouter->zone                      = 'outer';
    $dbouter->setRowsPerPage(1);  // only show one item at a time
    $dbouter->checkPrimaryKey = true;  // check that primary key is complete
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
        $dbinner->restart($return_from, $return_action, $return_string, $return_files);
    } // if
    // get data from previous instance
    $inner_data = $dbinner->getFieldArray();
    // get any extra data and merge with $fieldarray
    $inner_data = $dbinner->getExtraData($inner_data);
} else {
    $dbinner = new $inner_table;
    // indicate that this object was started from a page controller
    $dbinner->initiated_from_controller = true;
    $dbinner->zone                      = 'inner';
    $dbinner->rows_per_page          = 0;   // turn off pagination
    $dbinner->xsl_params['noshow']   = 'y'; // turn off page size selection
    $dbinner->xsl_params['noselect'] = 'y'; // turn off row selection
    // perform any initialisation
    $null = $dbinner->initialise($original_where, $original_selection);
    if ($dbinner->errors) {
        scriptPrevious($dbinner->getErrors());
    } // if
} // if

$dbouter->setChildObject($dbinner);
$dbinner->setParentObject($dbouter);

if (!empty($_POST)) {
    // identify if one of the 'submit' buttons has been pressed
    $submit_button = check_submit_button ($act_buttons, $_POST);
    if (empty($submit_button)) {
        // deal with a javascript 'submit()'.
        $outer_data = $dbouter->updateFieldArray($outer_data, $_POST);
        if ($dbouter->errors) {
            $errors[$dbouter->getClassName()] = $dbouter->getErrors();
        } // if
        if (empty($errors)) {
            // repeat for the inner entity
            $inner_data = $dbinner->getFieldArray();
            $inner_data = $dbinner->updateFieldArray($inner_data, $_POST);
            if ($dbinner->errors) {
                $errors[$dbinner->getClassName()] = $dbinner->getErrors();
            } // if
        } // if
    } else {
        // merge original data with POSTed data (so that fields which were displayed
        // but not POSTed are sent back if any errors are displayed).
        $outer_post = getPostArray($_POST, $dbouter->getFieldSpec());
        $outer_data = array_update_associative($outer_data, $outer_post, $dbouter->fieldspec);
        $dbouter->setFieldArray($outer_data);  // ensure that changes are stored inside relevant object
        // repeat for the inner entity
        $inner_post = getPostArray($_POST, $dbinner->getFieldSpec());
        $inner_data = array_update_indexed($inner_data, $inner_post);
        $dbinner->setFieldArray($inner_data);  // ensure that changes are stored inside relevant object
    } // if
    if (empty($errors)) {
        // look for a navigation or popup button which jumps to another script
        $child_errors = childForm($_POST, array('dbouter' => &$dbouter, 'dbinner' => &$dbinner));
        if (is_array($child_errors)) {
            $errors = array_merge($errors, $child_errors);
        } // if
    } // if
    if (empty($errors)) {
        if (!empty($submit_button)) {
            // a SUBMIT button was pressed, so update the database
            $dbinner->startTransaction();
            $outer_data = $dbouter->updateRecord($outer_data);
            $outer_data = $dbouter->getExtraData($outer_data);
            if ($dbouter->errors) {
                // errors are keyed by object name
                $errors[$dbouter->getClassName()] = $dbouter->getErrors();
            } // if
            if (empty($errors)) {
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
                        $inner_data = $dbinner->getExtraData($inner_data);
                    } else {
                        // update was OK - return to previous screen
                        scriptPrevious($errors, $messages, 'insert', $dbinner->getInstruction());
                    } // if
                } // if
            } // if

        } else {
	        // look for a custom button (a field which begins with 'button#')
	        $button = false;
            foreach ($_POST as $postname => $postvalue) {
        	    if (preg_match('/^button#/i', $postname, $regs)) {
        	        // strip off the prefix to leave the original field name
        		    $button = str_replace($regs[0], '', $postname);
                    if (is_array($postvalue)) {
                        $button_row = key($postvalue);
                    } else {
                        $button_row = null;
                    } // if
        		    break;
        	    } // if
            } // foreach
            if ($button) {
        	    $dbinner->startTransaction();
                // a custom button was pressed - send it to both entities
                $outer_data = $dbouter->customButton($outer_data, $button, $_POST);
                if ($dbouter->errors) {
                    $errors[$dbouter->getClassName()] = $dbouter->getErrors();
                } // if
                if (empty($errors)) {
                    $inner_data = $dbinner->getFieldArray();
                    $inner_data = $dbinner->customButton($inner_data, $button, $_POST, $button_row);
                    if ($dbinner->errors) {
                        $errors[$dbinner->getClassName()] = $dbinner->getErrors();
                    } // if
                } // if
                if (empty($errors)) {
                    $dbinner->commit();
                } else {
                    $dbinner->rollback();
                } // if
            } // if
        } // if
    } // if
    // refetch data in case it has changed
    $outer_data  = $dbouter->getFieldArray();
    $inner_data  = $dbinner->getFieldArray();
} // if

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    // check to see if we are returning from a child form
    if (!empty($return_from) AND !empty($popup_object)) {
        if (isset($selection) AND $popup_object == 'dbouter') {
            // merge previous saved variables with selection from popup form
            $outer_data = $dbouter->popupReturn($outer_data, basename($return_from), $selection, $popup_offset, $return_files);
            if ($dbouter->errors) {
            	$errors[$dbouter->getClassName()] = $dbouter->getErrors();
            } // if
            $inner_data = $dbinner->getFieldArray();
        } elseif (isset($selection) AND $popup_object == 'dbinner') {
            $inner_data = $dbinner->popupReturn($inner_data, basename($return_from), $selection, $popup_offset);
            if ($dbinner->errors) {
                $errors[$dbinner->getClassName()] = $dbinner->getErrors();
            } // if
        } // if
    } else {
        // get data from the outer table
        $outer_data = $dbouter->getData($where);
        $outer_data = $dbouter->getExtraData($outer_data);
        if ($dbouter->errors) {
            // some sort of error, so return to calling script
            scriptprevious($dbouter->getErrors(), $messages);
        } // if
        if ($dbouter->getNumRows() < 1) {
            scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
        } // if

        // save these variables for later in the same session in case INNER performs a scriptNext()
        $script_vars['where']     = unqualifyWhere($where);
        $script_vars['dbouter']   = serialize($dbouter);
        $script_vars = updateScriptVars ($script_vars);

        // get data for INNER entity
        $inner_data = $dbinner->getInitialDataMultiple($outer_data);
        $inner_data = $dbinner->getExtraData($inner_data);
        if ($dbinner->errors) {
            $errors[$dbinner->getClassName()] = $dbinner->getErrors();
        } // if

        $dbinner->numrows = count($inner_data);
        if ($dbinner->getNumRows() == 0) {
            $errors[] = getLanguageText('sys0088', strtoupper($inner_table)); // 'No entries found on $inner_table'
            unset($act_buttons['submitBtn']);
            unset($act_buttons['submitstay']);
        } // if
    } // if
} // if

// save these variables for later in the same session
$script_vars['where']     = unqualifyWhere($where);
$script_vars['dbouter']   = serialize($dbouter);
$script_vars['dbinner']   = serialize($dbinner);
$script_vars = updateScriptVars ($script_vars);

$dbouter->fieldarray = $outer_data;  // replace data lost during serialization
$dbinner->fieldarray = $inner_data;

if ($_SERVER['REQUEST_METHOD'] == 'POST' AND empty($errors) AND !$button) {
    // repeat current task with GET instead of POST
    scriptNext($GLOBALS['task_id'], $where);
} // if

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbouter;
$xml_objects[][$dbouter->getClassName()] = &$dbinner;

// build XML document and perform XSL transformation
$view = new radicore_view($screen_structure);
$view->buildXML($xml_objects, $errors, $messages);
exit;

?>
