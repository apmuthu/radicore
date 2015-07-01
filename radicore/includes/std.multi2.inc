<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2015 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.multi2.inc

// type = multi2

// This will display data from 2 tables in a ONE-to-MANY relationship.
// (also known as a PARENT-CHILD or OUTER-INNER retaltionship).
// It will start by reading the OUTER entity using the primary key passed down
// from the previous screen, then show existing occurrences of INNER.
// Occurrences of INNER may then be modified, or added and deleted using the
// relevant buttons on the navigation bar.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'update';

// load session variables
initSession();

$original_where     = $where;
$original_selection = $selection;
if (!empty($selection) AND !isset($return_from)) {
	// $selection takes precedence over $where
    //$where     = $selection;
    //$selection = null;
    $new_selection = true;
} else{
    $new_selection = false;
} // if

if (isset($_POST['quit'])) {
    // clear this script from session details and return to previous page
    scriptPrevious(null, null, 'quit');
} // if

// define action buttons
$act_buttons['reset']      = 'reset';
$act_buttons['submitBtn']  = 'submit';  // do not use name 'submit' as this conflicts with javascript 'submit()' function.
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
        if (isset($scrolling[$dbouter->getClassName()])) {
            // current item may have been reset
            $scrolling[$dbouter->getClassName()]['curitem'] = $dbouter->getPageNo();
        } // if
    } // if
    // get previously retrieved data
    $outer_data = $dbouter->getFieldArray();
    // redo any configuration changes
    $outer_data = $dbouter->getExtraData($outer_data);
} else {
    // create new instance for initial activation of this script
    $dbouter = new $outer_table;
    // indicate that this object was started from a page controller
    $dbouter->initiated_from_controller = true;
    $dbouter->zone                      = 'outer';
    $dbouter->sql_select     = &$outer_sql_select;
    $dbouter->sql_from       = &$outer_sql_from;
    $dbouter->sql_where      = &$outer_sql_where;
    $dbouter->sql_groupby    = &$outer_sql_groupby;
    $dbouter->sql_having     = &$outer_sql_having;
    $dbouter->sql_orderby_table = &$outer_sql_orderby_table;
    if (!empty($outer_sql_orderby)) {
        $dbouter->setDefaultOrderby($outer_sql_orderby);
    } //if
    $dbouter->xsl_params = array('outer_noedit' => 'y');  // set this object to 'noedit'
    $dbouter->setRowsPerPage(1);  // scroll through one item at a time
    $dbouter->checkPrimaryKey = true;  // check that primary key is complete
    // perform any initialisation
    $where = $dbouter->initialise($original_where, $original_selection);
    if ($dbouter->errors) {
        scriptPrevious($dbouter->getErrors());
    } // if
    // set sort order (if defined)
    if (!empty($orderby)) {
        $string = validateSortItem('outer', $orderby, $dbouter, $screen_structure);
        $dbouter->setOrderBy($string);
        if (!empty($orderby_seq)) {
            $dbouter->setOrderBySeq($orderby_seq);
        } // if
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
    // get previously retrieved data
    $inner_data = $dbinner->getFieldArray();
    // redo any configuration changes
    $inner_data = $dbinner->getExtraData($inner_data);
} else {
    $dbinner = new $inner_table;
    // indicate that this object was started from a page controller
    $dbinner->initiated_from_controller = true;
    $dbinner->zone                      = 'inner';
    $dbinner->sql_select       = &$inner_sql_select;
    $dbinner->sql_from         = &$inner_sql_from;
    $dbinner->sql_where        = &$inner_sql_where;
    $dbinner->sql_groupby      = &$inner_sql_groupby;
    $dbinner->sql_having       = &$inner_sql_having;
    $dbinner->sql_search_table = &$inner_search_table;
    if (!empty($task_selection)) {
        $dbinner->setSqlWhere($task_selection);
    } // if
    if (!empty($inner_sql_orderby)) {
        $dbinner->setDefaultOrderby($inner_sql_orderby);
    } elseif (!empty($task_orderby)) {
        $dbinner->setDefaultOrderby($task_orderby);
    } // if
    // perform any initialisation
    $null = $dbinner->initialise($original_where, $original_selection);
    if ($dbinner->errors) {
        scriptPrevious($dbinner->getErrors());
    } // if
} // if

if (preg_match('/(\(add2\)|\(add3\))/i', $return_from)) {
    $do_retrieve = true;
    $selection   = null;
} else {
    $do_retrieve = false;
} // if

// make each object available to its parent or child
$dbouter->setChildObject($dbinner);
$dbinner->setParentObject($dbouter);

if (isset($_POST['reset'])) {
    $where = $dbouter->reset($task_selection);
    $outer_data = $dbouter->getFieldArray();
    $where = $dbinner->reset($where);
    $inner_data = $dbinner->getFieldArray();
    $_POST = array();  // no further POST action required
    $do_retrieve = true;  // read the database for current data
} // if

if (!empty($_POST)) {
    // identify if one of the 'submit' buttons has been pressed
    $submit_button = check_submit_button ($act_buttons, $_POST);
    if (empty($submit_button)) {
        // deal with a javascript 'submit()'.
        $inner_data = $dbinner->updateFieldArray($inner_data, $_POST);
        if ($dbinner->errors) {
            $errors[$dbinner->getClassName()] = $dbinner->getErrors();
        } // if
    } else {
        // merge original data with POSTed data (so that fields which were displayed
        // but not POSTed are sent back if any errors are displayed).
        $inner_post = getPostArray($_POST, $dbinner->getFieldSpec());
        $inner_data = array_update_indexed($inner_data, $inner_post);
        // ensure that changes are stored inside relevant object
        $dbinner->setFieldArray($inner_data);
    } // if
    if (empty($errors)) {
        // look for an action which is another script (navigation or popup button)
        $child_errors = childForm($_POST, array('dbouter' => $dbouter, 'dbinner' => $dbinner));
        if (is_array($child_errors)) {
            $errors = array_merge($errors, $child_errors);
        } // if
    } // if
    if (empty($errors)) {
        if (!empty($submit_button)) {
            $dbinner->startTransaction();
            // update database with changes in POST array
            $inner_data = $dbinner->updateMultiple($inner_data, $_POST);
            $inner_data = $dbinner->getExtraData($inner_data);
            if ($dbinner->errors) {
                $errors[$dbinner->getClassName()] = $dbinner->getErrors();
            } // if
            if ($dbinner->errors) {
                // errors are keyed by object name
                $errors[$dbinner->getClassName()] = $dbinner->getErrors();
            } // if
            if (empty($errors)) {
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
                        // update was OK - return to previous screen
                        scriptPrevious($errors, $messages, 'OK', $dbinner->getInstruction());
                    } // if
                } // if
                $do_retrieve = true;
            } // if

        } else {
            // form posted WITHOUT one of the submit buttons
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
                // a custom button was pressed - send it to all relevant entities
                $inner_data = $dbinner->getFieldArray();
                $inner_data = $dbinner->customButton($inner_data, $button, $_POST, $button_row);
                if ($dbinner->errors) {
                    $errors[$dbinner->getClassName()] = $dbinner->getErrors();
                } // if
                if (empty($errors)) {
                    $dbinner->commit();
                    $do_retrieve = true;
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

// check if we are returning from a child form
if (!empty($return_from) AND isset($selection)) {
    // merge previous saved variables with selection from popup form
    $inner_data = $dbinner->popupReturn($inner_data, basename($return_from), $selection, null, $return_files);
    if ($dbinner->errors) {
        $errors[$dbinner->getClassName()] = $dbinner->getErrors();
    } // if

} elseif ($_SERVER['REQUEST_METHOD'] == 'GET' OR !empty($search) OR $do_retrieve) {
    if (isset($scrolling)) {
        if (!empty($search) AND !empty($dbouter->scrollarray)) {
            $dbouter->setScrollArray($search);
            $new_selection = true;
        } // if
        if ($new_selection === true) {
    	    // selection has changed, so use new value in $where
        	$dbouter->setPageNo(1);
        } else {
            // use previous values from scrolling array
            $where = $scrolling[$dbouter->getClassName()]['where'];
            if (isset($_GET['scrolling']) AND $_GET['scrolling'] == $dbouter->getClassName()) {
                // set index number of item to be read from current $where list
                $dbouter->setPageNo($_GET['item']);
            } // if
        } // if
    } // if

    if (empty($where)) {
        if ($dbouter->allow_empty_where == TRUE) {
            // this class is allowed to read multiple records
            if (isset($search)) {
                // load in any search criteria
                $dbouter->setSqlSearch($search);
            } // if
        } else {
            scriptPrevious(getLanguageText('sys0082')); // 'No parent has been selected yet.'
        } // if
    } // if

    if (empty($errors)) {
        // get data from the outer table
        $outer_data = $dbouter->getData($where);
        $outer_data = $dbouter->getExtraData($outer_data);
        if ($dbouter->errors) {
            $errors[$dbouter->getClassName()] = $dbouter->getErrors();
        } // if
        if ($dbouter->errors) {
            // some sort of error
            if ($dbouter->getLastPage() <= 1) {
                // only 1 entry requested, so return to previous script to show the error
                scriptPrevious($dbouter->getErrors(), $messages);
            } else {
                // multiple entries requested, so disable SUBMIT button
                unset($act_buttons['submitBtn']);
                unset($act_buttons['submitnext']);
                if ($dbouter->errors) {
            	    $errors[$dbouter->getClassName()] = $dbouter->getErrors();
                } // if
            } // if
        } // if
        if ($dbouter->getNumRows() < 1) {
            scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
        } // if

        // save these variables for later in the same session in case INNER performs a scriptNext()
        $script_vars['where']     = unqualifyWhere($where);
        $script_vars['dbouter']   = serialize($dbouter);
        $script_vars['scrolling'] = $scrolling;
        $script_vars = updateScriptVars ($script_vars);

        $dbouter->fieldarray = $outer_data;  // replace data lost during serialization
    } // if

    if (isset($_SESSION['rowsperpage'])) {
        $dbinner->setRowsPerPage($_SESSION['rowsperpage']);
    } // if

    if (isset($_GET['pagesize'])) {
        $dbinner->setRowsPerPage($_GET['pagesize']);
        $_SESSION['rowsperpage'] = $_GET['pagesize'];
    } // if

    // obtain the 'orderby' field (optional)
    if (isset($_GET['orderby'])) {
        $string = validateSortItem('inner', $_GET['orderby'], $dbinner, $screen_structure);
        $dbinner->setOrderBy($string, $dbinner->sql_orderby_seq);
    } // if

    // load optional criteria from search screen
    if (isset($search)) {
        $dbinner->setSqlSearch($search, true);
    } // if

    // get primary key of row retrieved from OUTER entity
    $pkeynames = $dbouter->getPkeyNamesAdjusted();
    $outer_where = array2where($outer_data, $pkeynames, $dbouter, false, true);

    // obtain the required page number (optional)
    if (isset($_GET['page'])) {
        $dbinner->setPageNo($_GET['page']);
    } // if

    // only read INNER if OUTER is not empty
    if (count($outer_data) > 0) {
        if (!empty($return_from) AND isset($selection)) {
            $inner_data = $dbinner->popupReturn($inner_data, basename($return_from), $selection, $popup_offset, $return_files);
        } else {
            // load in current data from $outer in case it is needed
            $dbinner->setFieldArray($outer_data);

            if (empty($errors[$dbinner->getClassName()])) {
        	    // no errors, so get data from the database
                $inner_data = $dbinner->getData($outer_where);
                $inner_data = $dbinner->getExtraData($inner_data);
            } // if
            if ($dbinner->errors) {
                $errors[$dbinner->getClassName()] = $dbinner->getErrors();
            } // if

            if ($dbinner->getNumRows() == 0) {
                if (!empty($return_from) AND ($return_action == 'OK')) {
                    // have returned to this occurrence after it has been processed, so...
                    if ($scrolling[$dbouter->getClassName()]['curitem'] == $scrolling[$dbouter->getClassName()]['lastitem']) {
            	        // this is the last occurrence, so exit
            		    scriptprevious($errors, $messages);
            	    } else {
            	        // restart from next occurrence
            	        $object = $dbouter->getClassName();
            	        $item = $scrolling[$object]['curitem']+1;
            	        scriptRestart ($dbinner, $query_string="scrolling=$object&item=$item");
            	    } // if
                } else {
                    $errors[] = getLanguageText('sys0088', strtoupper($inner_table)); // 'No entries found on $inner_table'
                    unset($act_buttons['submitBtn']);
                    unset($act_buttons['submitnext']);
                } // if
            } // if
        } // if
    } // if
} // if

if (isset($_GET['action'])) {
    $inner_data = $dbinner->setAction($_GET['action']);
} // if

$messages = $dbouter->getMessages();
$messages = array_merge($messages, $dbinner->getMessages());

// save details to enable scrolling for outer entity
$scrolling[$dbouter->getClassName()]['curitem']  = $dbouter->getPageNo();
$scrolling[$dbouter->getClassName()]['lastitem'] = $dbouter->getLastPage();
$scrolling[$dbouter->getClassName()]['where']    = $where;

// save details to enable pagination for inner entity
$pagination['inner']['numrows']  = $dbinner->getNumRows();
$pagination['inner']['curpage']  = $dbinner->getPageNo();
$pagination['inner']['lastpage'] = $dbinner->getLastPage();

// save these variables for later in the same session
$script_vars['where']     = unqualifyWhere($where);
$script_vars['dbouter']   = serialize($dbouter);
$script_vars['dbinner']   = serialize($dbinner);
$script_vars['scrolling'] = $scrolling;
$script_vars = updateScriptVars ($script_vars);

$dbouter->fieldarray = $outer_data;  // replace data lost during serialization
$dbinner->fieldarray = $inner_data;

if ($_SERVER['REQUEST_METHOD'] == 'POST' AND empty($errors)) {
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
