<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2017 by Radicore Software Limited <http://www.radicore.org>
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

if (!empty($selection) AND (!isset($return_from) OR $return_action == 'choose')) {
    // $selection takes precedence over $where
    //$where     = $selection;
    //$selection = null;
    $new_selection = true;
} else{
    $new_selection = false;
} // if

if (isset($_POST['quit']) OR isset($_GET['quit'])) {
    if (isset($script_vars['dbouter'])) {
        require_once "classes/$outer_table.class.inc";
        $dbouter = unserialize($script_vars['dbouter']);
        $dbouter->quitButton();  // perform any QUIT processing
    } // if
    if (isset($script_vars['dbinner'])) {
        require_once "classes/$inner_table.class.inc";
        $dbinner = unserialize($script_vars['dbinner']);
        $dbinner->quitButton();  // perform any QUIT processing
    } // if
    // clear this script from session details and return to previous page
    scriptPrevious(null, null, 'quit');
} // if

// define action buttons
$act_buttons['submitBtn']  = 'submit';  // do not use name 'submit' as this conflicts with javascript 'submit()' function.
$act_buttons['submitstay'] = 'submitstay';
$act_buttons['submitnext'] = 'submitnext';
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
    //$outer_data = $dbouter->getExtraData($outer_data);  // this conflicts with javascript submit (updateFieldArray)
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
        scriptPrevious($dbouter->getErrors(), $messages, 'fail');
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
    //$inner_data = $dbinner->getExtraData($inner_data);  // this conflicts with javascript submit (updateFieldArray)
} else {
    $dbinner = new $inner_table;
    // indicate that this object was started from a page controller
    $dbinner->initiated_from_controller = true;
    $dbinner->zone                      = 'inner';
    $dbinner->rows_per_page             = 0;   // turn off pagination
    $dbinner->xsl_params['noshow']      = 'y'; // turn off page size selection
    $dbinner->xsl_params['noselect']    = 'y'; // turn off row selection
    // perform any initialisation
    $null = $dbinner->initialise($original_where, $original_selection);
    if ($dbinner->errors) {
        scriptPrevious($dbinner->getErrors(), $messages, 'fail');
    } // if
} // if

$dbouter->setChildObject($dbinner);
$dbinner->setParentObject($dbouter);

if (!empty($_POST)) {
    $messages = array();
    // identify if one of the 'submit' buttons has been pressed
    $submit_button = check_submit_button($act_buttons, $_POST);
    $task_button   = check_task_button($_POST);
    $custom_button = check_custom_button($_POST);
    if ($submit_button OR $task_button OR $custom_button) {
        // merge original data with POSTed data (so that fields which were displayed
        // but not POSTed are sent back if any errors are displayed).
        $outer_post = getPostArray($_POST, $dbouter->getFieldSpec());
        $outer_data = array_update_associative($outer_data, $outer_post, $dbouter->fieldspec);
        $dbouter->setFieldArray($outer_data);  // ensure that changes are stored inside relevant object
        // repeat for the inner entity
        $inner_post = getPostArray($_POST, $dbinner->getFieldSpec(), true);
        $inner_data = array_update_indexed($inner_data, $inner_post);
        $dbinner->setFieldArray($inner_data);  // ensure that changes are stored inside relevant object

    } else {
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
    } // if

    if (empty($errors) AND !empty($task_button)) {
        // look for a navigation or popup button which jumps to another script
        $child_errors = childForm($_POST, array('dbouter' => &$dbouter, 'dbinner' => &$dbinner), $task_button);
        if (is_array($child_errors)) {
            $errors[$dbobject->getClassName()] = $child_errors;
        } // if

    } elseif (empty($errors) AND !empty($custom_button)) {
        // a custom button was pressed - send it to both entities
        list($custom_btn, $btn_row, $btn_zone) = $custom_button;
        // save current data in case a custom button jumps to another script
        $script_vars['dbouter'] = serialize($dbouter);
        $script_vars['dbinner'] = serialize($dbinner);
        if ($btn_zone == $dbouter->zone OR is_True($dbouter->allow_buttons_all_zones)) {
            $outer_data = $dbouter->customButton($outer_data, $custom_btn, $_POST);
            if ($dbouter->errors) {
                $errors[$dbouter->getClassName()] = $dbouter->getErrors();
            } // if
        } // if
        if ($btn_zone == $dbinner->zone OR is_True($dbinner->allow_buttons_all_zones)) {
            $inner_data = $dbinner->getFieldArray();
            $inner_data = $dbinner->customButton($inner_data, $custom_btn, $_POST, $btn_row);
            if ($dbinner->errors) {
                $errors[$dbinner->getClassName()] = $dbinner->getErrors();
            } // if
        } // if
        unset($custom_button);

    } elseif (empty($errors) AND !empty($submit_button)) {
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
        $messages = array_merge($messages, $dbouter->getMessages());
        $messages = array_merge($messages, $dbinner->getMessages());
        if ($errors) {
            $dbinner->rollback();
        } else {
            // update was OK
            $dbinner->wf_case_id     = $dbouter->wf_case_id;
            $dbinner->wf_workitem_id = $dbouter->wf_workitem_id;
            $dbinner->wf_context     = $dbouter->wf_context;
            $errors = $dbinner->commit();
            if (empty($errors)) {
                $messages[] = getLanguageText('sys0091'); // 'Update successful'
            } // if
            if (isset($_POST['submitnext'])) {
                $curitem  = $scrolling[$dbouter->getClassName()]['curitem'];
                $lastitem = $scrolling[$dbouter->getClassName()]['lastitem'];
                if ($curitem < $lastitem) {
                    // skip to the next item
                    $curitem++;
                    $scrolling[$dbouter->getClassName()]['curitem'] = $curitem;
                    $dbouter->setPageNo($curitem);
                    $where = $scrolling[$dbouter->getClassName()]['where'];
                    $fieldarray = $dbouter->getData($where);
                    $scrolling[$dbouter->getClassName()]['lastitem'] = $dbouter->getLastPage();
                } else {
                    // there is no next item, so return to previous screen
                    scriptPrevious($errors, $messages, 'update', $dbinner->getInstruction());
                } // if
            } // if
        } // if
    } // if
    // refetch data in case it has changed
    $outer_data  = $dbouter->getFieldArray();
    $inner_data  = $dbinner->getFieldArray();
} // if

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    if (isset($scrolling)) {
        if ($new_selection === true) {
            // selection has changed, so use new value in $where
            $dbouter->setPageNo(1);
        } else {
            // use previous values from scrolling array
            $where = $scrolling[$dbouter->getClassName()]['where'];
            if (isset($_GET['scrolling']) AND $_GET['scrolling'] == $dbouter->getClassName()) {
                // set index number of item to be read from current $where list
                $dbouter->setPageNo($_GET['item']);
            } else {
                $dbouter->setPageNo($scrolling[$dbouter->getClassName()]['curitem']);
            } // if
        } // if
    } // if
    // check to see if we are returning from a child form
    if (!empty($return_from) AND !empty($popup_object)) {
        if (isset($selection) AND $popup_object == 'dbouter') {
            // merge previous saved variables with selection from popup form
            $outer_data = $dbouter->popupReturn($outer_data, basename($return_from), $selection, null, $return_files);
            if ($dbouter->errors) {
            	$errors[$dbouter->getClassName()] = $dbouter->getErrors();
            } // if
            $inner_data = $dbinner->getFieldArray();
        } elseif (isset($selection) AND $popup_object == 'dbinner') {
            $inner_data = $dbinner->popupReturn($inner_data, basename($return_from), $selection, $popup_offset, $return_files);
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
            scriptprevious($dbouter->getErrors(), $messages, 'fail');
        } // if
        if ($dbouter->getNumRows() < 1) {
            scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
        } // if

        // set variables to be included in XML output
        $scrolling[$dbouter->getClassName()]['curitem']  = $dbouter->getPageNo();
        $scrolling[$dbouter->getClassName()]['lastitem'] = $dbouter->getLastPage();
        $scrolling[$dbouter->getClassName()]['where']    = $where;

        // save these variables for later in the same session in case INNER performs a scriptNext()
        $script_vars['where']     = unqualifyWhere($where);
        $script_vars['dbouter']   = serialize($dbouter);
        $script_vars['scrolling'] = $scrolling;
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
$script_vars['scrolling']  = $scrolling;
$script_vars = updateScriptVars ($script_vars);

$dbouter->fieldarray = $outer_data;  // replace data lost during serialization
$dbinner->fieldarray = $inner_data;

if ($_SERVER['REQUEST_METHOD'] == 'POST' AND empty($errors) AND $submit_button) {
    // repeat current task with GET instead of POST
    scriptNext($GLOBALS['task_id'], $where);
} // if

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbouter;
$xml_objects[][$dbouter->getClassName()] = &$dbinner;

// build XML document and perform XSL transformation
$view = new radicore_view($screen_structure);
$html = $view->buildXML($xml_objects, $errors, $messages);
echo $html;
exit;

?>
