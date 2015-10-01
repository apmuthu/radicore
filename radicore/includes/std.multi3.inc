<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2015 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.multi3.inc

// type = multi3

// This will allow multiple occurrences of INNER in a OUTER-to-MIDDLE-to-INNER
// relationship to be maintained, where:
// OUTER-to-MIDDLE is ONE-to-MANY and
// INNER-to-MIDDLE is ONE-to-MANY.
// In other words this is a ONE-to-MANY-to-ONE relationship.
// The OUTER entity can be swapped with the INNER entity and this function will
// still work.
// The primary key of the OUTER entity will be passed down from the previous
// screen in $where.
// The remaining ONE entity will be designated as INNER. It will start by displaying
// the first available row, with hyperlinks to scroll forwards and backwards.
// The primary key of the OUTER and current INNER entties will be used to fetch
// records from the MANY entity.

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
    $dbouter->initiated_from_controller  = true;
    $dbouter->zone                       = 'outer';
    $dbouter->xsl_params['outer_noedit'] = 'y';
    $dbouter->setRowsPerPage(1);  // display one row at a atime
    $dbouter->sql_select     = &$outer_sql_select;
    $dbouter->sql_from       = &$outer_sql_from;
    $dbouter->sql_where      = &$outer_sql_where;
    $dbouter->sql_groupby    = &$outer_sql_groupby;
    $dbouter->sql_having     = &$outer_sql_having;
    $dbouter->sql_orderby_table = &$outer_sql_orderby_table;
    if (!empty($outer_sql_orderby)) {
        $dbouter->setDefaultOrderby($outer_sql_orderby);
    } // if
    // check that primary key is complete
    $dbouter->checkPrimaryKey = true;
    // perform any initialisation
    $where = $dbouter->initialise($where, $selection);
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

// create a class instance for the MIDDLE database table
require_once "classes/$middle_table.class.inc";
if (isset($script_vars['dbmiddle'])) {
    // use previous instance from session data
    $dbmiddle = unserialize($script_vars['dbmiddle']);
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $dbmiddle->restart($return_from, $return_action, $return_string, $return_files);
    } // if
    // get previously retrieved data
    $middle_data = $dbmiddle->getFieldArray();
    // redo any configuration changes
    $middle_data = $dbmiddle->getExtraData($middle_data);
} else {
    // create new instance for initial activation of this script
    $dbmiddle = new $middle_table;
    // indicate that this object was started from a page controller
    $dbmiddle->initiated_from_controller   = true;
    $dbmiddle->zone                        = 'middle';
    $dbmiddle->xsl_params['middle_noedit'] = 'y';
    $dbmiddle->setRowsPerPage(1);  // scroll through one item at a time
    $dbmiddle->sql_select  = &$middle_sql_select;
    $dbmiddle->sql_from    = &$middle_sql_from;
    $dbmiddle->sql_where   = &$middle_sql_where;
    $dbmiddle->sql_groupby = &$middle_sql_groupby;
    $dbmiddle->sql_having  = &$middle_sql_having;
    if (!empty($task_selection)) {
        $dbmiddle->setSqlWhere($task_selection);
    } // if
    if (!empty($middle_sql_orderby)) {
        $dbmiddle->setDefaultOrderby($middle_sql_orderby);
    } elseif (!empty($task_orderby)) {
        $dbmiddle->setDefaultOrderby($task_orderby);
    } // if
    // perform any initialisation
    $null = $dbmiddle->initialise($original_where, $original_selection);
    if ($dbmiddle->errors) {
        scriptPrevious($dbmiddle->getErrors());
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
    // create new instance for initial activation of this script
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

$do_retrieve = false;

// make each object available to its parent or child
$dbouter->setChildObject($dbmiddle);
$dbmiddle->setParentObject($dbouter);
$dbmiddle->setChildObject($dbinner);
$dbinner->setParentObject($dbmiddle);

if (isset($_POST['reset'])) {
    $where = $dbouter->reset($where);
    $outer_data = $dbouter->getFieldArray();
    $where = $dbmiddle->reset($where);
    $middle_data = $dbmiddle->getFieldArray();
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
        $inner_data = $dbinner->getExtraData($inner_data, $where);
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
        $child_errors = childForm($_POST, array('dbmiddle' => &$dbmiddle, 'dbinner' => &$dbinner));
        if (is_array($child_errors)) {
            $errors = array_merge($errors, $child_errors);
        } // if
    } // if
    if (empty($errors)) {
        if (!empty($submit_button)) {
            $dbinner->startTransaction();
            // update database with changes in POST array
            $inner_data = $dbinner->updateMultiple($inner_data, $_POST);
            $inner_data = $dbinner->getExtraData($inner_data, $where);
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
                    $curitem  = $scrolling[$dbmiddle->getClassName()]['curitem'];
                    $lastitem = $scrolling[$dbmiddle->getClassName()]['lastitem'];
                    if ($curitem < $lastitem) {
                        // skip to the next item
                        $curitem++;
                        $scrolling[$dbmiddle->getClassName()]['curitem'] = $curitem;
                        $dbmiddle->setPageNo($curitem);
                        $where = $scrolling[$dbouter->getClassName()]['where'];
                        $fieldarray = $dbmiddle->getData($where);
                        $scrolling[$dbmiddle->getClassName()]['lastitem'] = $dbmiddle->getLastPage();
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
    $middle_data = $dbmiddle->getFieldArray();
    $inner_data  = $dbinner->getFieldArray();
} // if

// check if we are returning from a child form
if (!empty($return_from) AND isset($selection)) {
    // merge previous saved variables with selection from popup form
    $inner_data = $dbinner->popupReturn($inner_data, basename($return_from), $selection, $popup_offset, $return_files);
    if ($dbinner->errors) {
        $errors[$dbinner->getClassName()] = $dbinner->getErrors();
    } // if

} elseif ($_SERVER['REQUEST_METHOD'] == 'GET' OR !empty($search) OR $do_retrieve) {
    if (isset($scrolling)) {
        // use previous values from scrolling array
        $where = $scrolling[$dbouter->getClassName()]['where'];
        if (isset($_GET['scrolling']) AND $_GET['scrolling'] == $dbouter->getClassName()) {
            // set index number of item to be read from current $where list
            $dbouter->setPageNo($_GET['item']);
        } // if
    } // if
    if (empty($where)) {
        scriptPrevious(getLanguageText('sys0082')); // 'No parent has been selected yet.'
    } // if
    if (empty($errors)) {
        // get data from the outer table
        $outer_data = $dbouter->getData($where);
        $outer_data = $dbouter->getExtraData($outer_data, $where);
        if ($dbouter->errors) {
            $errors[$dbouter->getClassName()] = $dbouter->getErrors();
        } // if
        if ($dbouter->getNumRows() < 1) {
            scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
        } // if
    } // if

    // get primary key of current row retrieved from OUTER entity
    $pkeynames = $dbouter->getPkeyNamesAdjusted();
    $outer_where = array2where($outer_data, $pkeynames, $dbouter, false, true);

    if (isset($search)) {
        $dbmiddle->setSqlSearch($search);
    } // if

    if (isset($_GET['scrolling']) AND $_GET['scrolling'] == $dbmiddle->getClassName()) {
        // set index number of item to be read from current $where list
        $dbmiddle->setPageNo($_GET['item']);
    } // if

    // load in current data from $outer in case it is needed
    $dbmiddle->setFieldArray($outer_data);
    // get data from the middle table
    $middle_data = $dbmiddle->getData($outer_where);
    $middle_data = $dbmiddle->getExtraData($middle_data, $outer_where);
    if ($dbmiddle->errors) {
        // errors are keyed by object name
        $errors[$dbmiddle->getClassName()] = $dbmiddle->getErrors();
    } // if
    if ($dbmiddle->getNumRows() < 1) {
        // scriptPrevious('Nothing retrieved from the database.');
        $errors[] = getLanguageText('sys0088', strtoupper($dbmiddle->getClassName())); // 'No entries found on $dbmiddle'
        unset($act_buttons['submitBtn']);
    } // if

    // get primary key of row retrieved from middle entity
    $pkeynames = $dbmiddle->getPkeyNamesAdjusted();
    $middle_where = array2where($middle_data, $pkeynames, $dbmiddle, false, true);

    if (isset($_GET['pagesize'])) {
        $dbinner->setRowsPerPage($_GET['pagesize']);
        $_SESSION['rowsperpage'] = $_GET['pagesize'];
    } elseif (isset($_SESSION['rowsperpage'])) {
        $dbinner->setRowsPerPage($_SESSION['rowsperpage']);
    } // if

    // obtain the required page number (optional)
    if (isset($_GET['page'])) {
        $dbinner->setPageNo($_GET['page']);
    } elseif (!empty($pagination) AND !empty($pagination['inner'])) {
        $dbinner->setPageNo($pagination['inner']['curpage']);  // reset to last requested page
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

    if (isset($instruction)) {
        // load instruction returned by a child script
        $dbinner->setInstruction($instruction);
    } // if

    // merge OUTER and MIDDLE where to get selection criteria for INNER
    $inner_where = mergeWhere($outer_where, $middle_where);

    // only read INNER if MIDDLE is not empty
    if (count($middle_data) > 0) {
        // load in current data from $middle in case it is needed
        $dbinner->setFieldArray($middle_data);
        // get data from the database
        $inner_data = $dbinner->getData($inner_where);
        $inner_data = $dbinner->getExtraData($inner_data, $inner_where);
        if ($dbinner->errors) {
            $errors[$dbinner->getClassName()] = $dbinner->getErrors();
        } // if

        if ($dbinner->getNumRows() == 0) {
            if (!is_array($errors)) {
                $errors = (array)$errors;
            } // if
            $errors[] = getLanguageText('sys0088', strtoupper($inner_table)); // 'No entries found on $inner_table'
            unset($act_buttons['submitBtn']);
        } // if
    } // if
} // if

if (isset($_GET['action'])) {
    $inner_data = $dbinner->setAction($_GET['action']);
} // if

$messages = $dbouter->getMessages();
$messages = array_merge($messages, $dbmiddle->getMessages());
$messages = array_merge($messages, $dbinner->getMessages());

// save details to enable scrolling for outer entity
$scrolling[$dbouter->getClassName()]['curitem']  = $dbouter->getPageNo();
$scrolling[$dbouter->getClassName()]['lastitem'] = $dbouter->getLastPage();
$scrolling[$dbouter->getClassName()]['where']    = $where;

// save details to enable scrolling for middle entity
$scrolling[$dbmiddle->getClassName()]['curitem']  = $dbmiddle->getPageNo();
$scrolling[$dbmiddle->getClassName()]['lastitem'] = $dbmiddle->getLastPage();
$scrolling[$dbmiddle->getClassName()]['where']    = $outer_where;

// save details to enable pagination for inner entity
$pagination['inner']['numrows']  = $dbinner->getNumRows();
$pagination['inner']['curpage']  = $dbinner->getPageNo();
$pagination['inner']['lastpage'] = $dbinner->getLastPage();

// save these variables for later in the same session
$script_vars['where']     = $where;
$script_vars['dbouter']   = serialize($dbouter);
$script_vars['dbmiddle']  = serialize($dbmiddle);
$script_vars['dbinner']   = serialize($dbinner);
$script_vars['scrolling'] = $scrolling;
$script_vars = updateScriptVars ($script_vars);

$dbouter->fieldarray  = $outer_data;  // replace data lost during serialization
$dbmiddle->fieldarray = $middle_data;
$dbinner->fieldarray  = $inner_data;

if ($_SERVER['REQUEST_METHOD'] == 'POST' AND empty($errors)) {
    // repeat current task with GET instead of POST
    scriptNext($GLOBALS['task_id'], $where);
} // if

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbouter;
$xml_objects[][$dbouter->getClassName()]  = &$dbmiddle;
$xml_objects[][$dbmiddle->getClassName()] = &$dbinner;

// build XML document and perform XSL transformation
$view = new radicore_view($screen_structure);
$view->buildXML($xml_objects, $errors, $messages);
exit;

?>
