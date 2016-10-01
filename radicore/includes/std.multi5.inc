<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.multi5.inc

// type = multi5

// This task has two zones - a top OUTER zone into which selection criteria can be
// entered, and a bottom INNER zone which will display multiple occurrences from a
// database table which match that search criteria.
//
// The top zone has a RETRIEVE button which be pressed to pass the current selection
// criteria to the bottom zone. The SUBMIT button will cause the bottom zone to be
// updated, but this zone can be made read-only.
//
// Note that the top zone is not connected to the database - all selection criteria
// is passed to the bottom zone for processing.

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
} // if

if (isset($_POST['quit'])) {
    // clear this script from session details and return to previous page
    scriptPrevious(null, null, 'quit');
} // if

// define action buttons
$act_buttons['submitBtn']  = 'submit';  // do not use name 'submit' as this conflicts with javascript 'submit()' function.
$act_buttons['submitnext'] = 'submitnext';
$act_buttons['reset']      = 'reset';
$act_buttons['quit']       = 'cancel';

// create a class instance for the OUTER database table
require_once "classes/$outer_table.class.inc";
if (isset($script_vars['dbouter'])) {
    // use previous instance from session data
    $dbouter = unserialize($script_vars['dbouter']);
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $dbouter->restart($return_from, $return_action, $return_string, $return_files);
    } // if
    // get data from this instance
    $outer_data = $dbouter->getFieldArray();
    // redo any configuration changes
    $outer_data = $dbouter->getExtraData($outer_data);
} else {
    // create new instance for initial activation of this script
    $dbouter = new $outer_table;
    // indicate that this object was started from a page controller
    $dbouter->initiated_from_controller = true;
    $dbouter->zone                      = 'outer';
    $dbouter->setRowsPerPage(1);
    // perform any initialisation
    $where = $dbouter->initialise($original_where, $original_selection);
    if ($dbouter->errors) {
        scriptPrevious($dbouter->getErrors(), $messages, 'fail');
    } // if
    $dbouter->no_foreign_data = TRUE;  // do not look up data for foreign keys
    // add a 'retrieve' button
    $dbouter->fieldspec['retrieve'] = array('type' => 'string', 'control' => 'button');
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
    // get data from this instance
    $inner_data = $dbinner->getFieldArray();
    // redo any configuration changes
    $inner_data = $dbinner->getExtraData($inner_data);
} else {
	// create new instance for initial activation of this script
    $dbinner = new $inner_table;
    // indicate that this object was started from a page controller
    $dbinner->initiated_from_controller = true;
    $dbinner->zone                      = 'inner';
    //$dbinner->xsl_params['inner_noedit'] = 'y';
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
        scriptPrevious($dbinner->getErrors(), $messages, 'fail');
    } // if
    // set sort order (if defined)
    if (!empty($orderby)) {
        $string = validateSortItem('inner', $orderby, $dbinner, $screen_structure);
        $dbinner->setOrderBy($string);
        if (!empty($orderby_seq)) {
            $dbinner->setOrderBySeq($orderby_seq);
        } // if
    } // if
} // if

if (preg_match('/(insert|update|delete)/i', $return_action)) {
    $do_retrieve = true;
    $selection   = null;
} else {
    $do_retrieve = false;
} // if

// make each object available to its parent or child
$dbouter->setChildObject($dbinner);
$dbinner->setParentObject($dbouter);

if (isset($_POST['reset'])) {
    // initialise all settings to start afresh
    $dbouter->reset($where);
    $outer_data = $dbouter->getFieldArray();
    $dbinner->reset($where);
    $inner_data = $dbinner->getFieldArray();
    $_POST = array();  // no further POST action required
    $do_retrieve = true;  // read the database for current data
} // if

// ensure button contains a label
$outer_data = $dbouter->getFieldArray();
$outer_data['retrieve'] = getLanguageText('retrieve');
$dbouter->setFieldArray($outer_data);

if (!empty($_POST)) {
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
        // make any changes in outer available to the inner entity
        $dbinner->setParentData($outer_data);

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
            $errors = array_merge($errors, $child_errors);
        } // if

    } elseif (empty($errors) AND !empty($custom_button)) {
        // a custom button was pressed - send it to all relevant entities
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
        // update the database with all POSTed data
        $dbinner->startTransaction();
        if (empty($errors)) {
            $inner_data = $dbinner->updateMultiple($inner_data, $_POST);
            $inner_data = $dbinner->getExtraData($inner_data);
            if ($dbinner->errors) {
                // errors are keyed by object name
                $errors[$dbinner->getClassName()] = $dbinner->getErrors();
            } // if
        } // if
        if (empty($errors)) {
            // update was OK
            $messages = array_merge($messages, $dbinner->getMessages());
            $dbinner->wf_case_id     = $dbouter->wf_case_id;
            $dbinner->wf_workitem_id = $dbouter->wf_workitem_id;
            $dbinner->wf_context     = $dbouter->wf_context;
            $errors = $dbinner->commit();
            if (isset($_POST['submitnext'])) {
                // update was OK - return to previous screen
                scriptPrevious($errors, $messages, 'update', $dbinner->getInstruction());
            } // if
        } else {
            $dbinner->rollback();
        } // if
        $do_retrieve = true;
    } // if
    // refetch data in case it has changed
    $outer_data = $dbouter->getFieldArray();
    $inner_data = $dbinner->getFieldArray();
} // if

// check if we are returning from a child form
if (!empty($return_from) AND !empty($popup_object)) {
    if (isset($selection) AND $popup_object == 'dbouter') {
        // merge previous saved variables with selection from popup form
        $outer_data = $dbouter->popupReturn($outer_data, basename($return_from), $selection, null, $return_files);
        if ($dbouter->errors) {
            $errors[$dbouter->getClassName()] = $dbouter->getErrors();
        } // if
    } elseif (isset($selection) AND $popup_object == 'dbinner') {
        // merge previous saved variables with selection from popup form
        $inner_data = $dbinner->popupReturn($inner_data, basename($return_from), $selection, $popup_offset, $return_files);
        if ($dbinner->errors) {
            $errors[$dbinner->getClassName()] = $dbinner->getErrors();
        } // if
    } // if

} elseif ($_SERVER['REQUEST_METHOD'] == 'GET' OR !empty($search) OR $do_retrieve) {
    if (empty($errors)) {
        if (isset($_GET['scrolling'])) {
            if ($_GET['scrolling'] == $dbouter->getClassName()) {
                // set index number of item to be read from current $where list
                $dbouter->setPageNo($_GET['item']);
            } else {
                $dbouter->setPageNo($scrolling[$dbouter->getClassName()]['curitem']);
            } // if
        //} else {
        //    $dbouter->setPageNo(1);
        } // if
        $outer_data = $dbouter->getFieldArray();
        $outer_data = $dbouter->getExtraData($outer_data);
        if (is_True($dbinner->skip_getdata)) {
            // data is being handled manually, so skip this next bit
        } else {
            if (!isset($_GET['page'])) {
                $_GET['page'] = $dbinner->pageno;  // save this value so that it can be re-instated later
            } // if
            $inner_data  = $dbinner->setFieldArray(null);  // force retrieval of inner data
        } // if
    } // if

    if (isset($_GET['pagesize'])) {
        $dbinner->setRowsPerPage($_GET['pagesize']);
        $_SESSION['rowsperpage'] = $_GET['pagesize'];
    } elseif (isset($_SESSION['rowsperpage'])) {
        $dbinner->setRowsPerPage($_SESSION['rowsperpage']);
    } // if

    // obtain the required page number (optional)
    if (isset($_GET['page'])) {
        $dbinner->setPageNo($_GET['page']);
    } // if

    // obtain the 'orderby' field (optional)
    if (isset($_GET['orderby'])) {
        $string = validateSortItem('inner', $_GET['orderby'], $dbinner, $screen_structure);
        $dbinner->setOrderBy($string, $dbinner->sql_orderby_seq);
    } // if

    // load optional criteria from search screen
    if (isset($search)) {
        $dbouter->restart('search', 'search', $search);
        $dbinner->setSqlSearch($search, true);
    } // if

    // get primary key of row retrieved from OUTER entity
    $pkeynames = $dbouter->getPkeyNamesAdjusted();
    $where = array2where($outer_data, $pkeynames, $dbouter, false, true);

    if (!empty($outer_data)) {
        if (empty($inner_data)) {
            // get data from the database
            $inner_data = $dbinner->getData($where);
            $inner_data = $dbinner->getExtraData($inner_data);
        } else {
            if (!empty($dbinner->select_string)) {
                $inner_data = $dbinner->setSelectedRows($dbinner->select_string, $inner_data);
            } // if
        } // if
        if (empty($inner_data)) {
            $errors[] = getLanguageText('sys0088', strtoupper($inner_table)); // 'No entries found on $inner_table'
            //unset($act_buttons['submitBtn']);
        } // if
        if ($dbinner->errors) {
            $errors[$dbinner->getClassName()] = $dbinner->getErrors();
        } // if
    } // if
} // if

if (isset($_GET['action'])) {
    $inner_data = $dbinner->setAction($_GET['action']);
} // if

if (isset($dbinner->xsl_params['inner_noedit'])) {
    unset($act_buttons['submitBtn']);
    unset($act_buttons['submitnext']);
} // if

$messages = array_merge($messages, $dbouter->getMessages());
$messages = array_merge($messages, $dbinner->getMessages());

// set variables to be included in XML output
$scrolling[$dbouter->getClassName()]['curitem']  = $dbouter->getPageNo();
$scrolling[$dbouter->getClassName()]['lastitem'] = $dbouter->getLastPage();
$scrolling[$dbouter->getClassName()]['where']    = $dbouter->where;

// get pagination details
$pagination['inner']['numrows']  = $dbinner->getNumRows();
$pagination['inner']['curpage']  = $dbinner->getPageNo();
$pagination['inner']['lastpage'] = $dbinner->getLastPage();

// save these variables for later in the same session
$script_vars['where']      = unqualifyWhere($where);
$script_vars['dbouter']    = serialize($dbouter);
$script_vars['dbinner']    = serialize($dbinner);
$script_vars['scrolling']  = $scrolling;
$script_vars['pagination'] = $pagination;
$script_vars = updateScriptVars ($script_vars);

$dbouter->fieldarray  = $outer_data;  // replace data lost during serialization
$dbinner->fieldarray  = $inner_data;

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbouter;
$xml_objects[][$dbouter->getClassName()] = &$dbinner;

// build XML document and perform XSL transformation
$view = new radicore_view($screen_structure);
$html = $view->buildXML($xml_objects, $errors, $messages);
echo $html;
exit;

?>
