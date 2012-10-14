<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2011 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.multi4.inc

// type = multi4

// This will display data from 2 tables in a ONE-to-MANY relationship.
// (also known as a PARENT-CHILD or OUTER-INNER relationship).
// It will start by reading the OUTER entity using the primary key passed down
// from the previous screen, then show existing occurrences of INNER.
// The data on the OUTER entity may be updated.
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
} // if

if (isset($_POST['quit'])) {
    // clear this script from session details and return to previous page
    scriptPrevious(null, null, 'quit');
} // if

// define action buttons
$act_buttons['reset']      = 'reset';
$act_buttons['submit']     = 'submit';
$act_buttons['submitnext'] = 'submitnext';
$act_buttons['quit']       = 'cancel';

// create a class instance for the OUTER database table
require_once "classes/$outer_table.class.inc";
if (isset($script_vars['dbouter'])) {
    // use previous instance from session data
    $dbouter = unserialize($script_vars['dbouter']);
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $dbouter->restart($return_from, $return_action, $return_string);
    } // if
    // get data from this instance
    $outer_data = $dbouter->getFieldArray();
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
    } // if
    // scroll through one item at a time
    $dbouter->setRowsPerPage(1);
    // check that primary key is complete
    $dbouter->checkPrimaryKey = true;
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
        $dbinner->restart($return_from, $return_action, $return_string);
    } // if
    // get data from this instance
    $inner_data = $dbinner->getFieldArray();
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

if (!empty($_POST)) {
    // merge original data with POSTed data (so that fields which were displayed
    // but not POSTed are sent back if any errors are displayed).
    $outer_post = getPostArray($_POST, $dbouter->getFieldSpec());
    $outer_data = array_update_associative($outer_data, $outer_post, $dbouter->fieldspec);
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
if (isset($_POST['submit']) or isset($_POST['submitnext'])) {
    $dbouter->startTransaction();
    // update this data in the database
    $outer_data = $dbouter->updateRecord($outer_data);
    $messages = $dbouter->getMessages();
    if ($dbouter->errors) {
		// errors are keyed by object name
	    $errors[$dbouter->getClassName()] = $dbouter->getErrors();
	} else {
        if (is_True($dbouter->no_display_count)) {
            // do not display the record count
        } else {
        	// '$count records were updated in $tablename'
            $messages[] = getLanguageText('sys0006', $dbouter->numrows, strtoupper($dbouter->tablename));
        } // if
	} // if
    if (empty($errors)) {
        // update database with changes in POST array
        $inner_data = $dbinner->updateMultiple($inner_data, $inner_post);
        if ($dbinner->errors) {
            $dbinner->rollback();
    		// errors are keyed by object name
            $errors[$dbinner->getClassName()] = $dbinner->getErrors();
        } else {
            // update was OK
            $messages = array_merge($messages, $dbinner->getMessages());
            $dbinner->wf_case_id     = $dbouter->wf_case_id;
            $dbinner->wf_workitem_id = $dbouter->wf_workitem_id;
            $dbinner->wf_context     = $dbouter->wf_context;
            $errors = $dbinner->commit();
//            if (empty($errors)) {
//                if ($dbinner->no_controller_msg == TRUE) {
//                	// no messages from the controller, please
//                } else {
//                    // '$count records were updated in $tablename'
//                    $messages[] = getLanguageText('sys0006', $dbinner->numrows, strtoupper($dbinner->tablename));
//                } // if
//            } // if
            if (isset($_POST['submitnext'])) {
                $curitem  = $scrolling[$dbouter->getClassName()]['curitem'];
                $lastitem = $scrolling[$dbouter->getClassName()]['lastitem'];
                if ($curitem < $lastitem) {
                    // skip to the next item
                    $curitem++;
                    $scrolling[$dbouter->getClassName()]['curitem'] = $curitem;
                    $dbouter->setPageNo($curitem);
                    $where = $scrolling[$dbouter->getClassName()]['where'];
                    $outer_data = $dbouter->getData($where);
                    $scrolling[$dbouter->getClassName()]['lastitem'] = $dbouter->getLastPage();
                    $inner_data = $dbinner->setFieldArray(null);
                } else {
                    // update was OK - return to previous screen
                    scriptPrevious($errors, $messages, 'OK', $dbinner->getInstruction());
                } // if
            } // if
        } // if
    } else {
        $dbinner->rollback();
    } // if
} // if

if (isset($_POST['reset'])) {
    // initialise all settings to start afresh
    //$dbouter->reset($where);
    $dbouter->setPageNo(1);
    $dbouter->_cm_reset($where);
} // if

// check if we are returning from a child form
if (!empty($return_from) AND !empty($popup_object)) {
    if (isset($selection) AND $popup_object == 'dbouter') {
        // merge previous saved variables with selection from popup form
        $outer_data = $dbouter->popupReturn($outer_data, basename($return_from), $selection);
        if ($dbouter->errors) {
        	$errors[$dbouter->getClassName()] = $dbouter->getErrors();
        } // if
        // make any changes in outer available to the inner entity
        $inner_data = $dbinner->setParentData($outer_data);
    } // if
} else {
    if (isset($scrolling)) {
        // retrieve values from scrolling array
        $where = $scrolling[$dbouter->getClassName()]['where'];
        if (isset($_GET['scrolling']) AND $_GET['scrolling'] == $dbouter->getClassName()) {
            // set index number of item to be read from current $where list
            $dbouter->setPageNo($_GET['item']);
        } else {
            $dbouter->setPageNo($scrolling[$dbouter->getClassName()]['curitem']);
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

    if (empty($errors[$dbouter->getClassName()])) {
        // get data from the outer table
        $outer_data = $dbouter->getData($where);
        if ($dbouter->errors) {
            // some sort of error
            if ($dbouter->getLastPage() <= 1) {
                // only 1 entry requested, so return to previous script
                scriptprevious($dbouter->getErrors(), $messages);
            } else {
                // multiple entries requested, so disable SUBMIT button
                unset($act_buttons['submit']);
                if ($dbouter->errors) {
                	$errors[$dbouter->getClassName()] = $dbouter->getErrors();
                } // if
            } // if
        } // if
        if (empty($outer_data)) {
        	scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
        } // if
        $inner_data = $dbinner->setFieldArray(null);  // force retrieval of inner data
        $dbinner->setPageNo($pagination['inner']['curpage']);  // reset to last requested page
    } // if

    // get any additional data for the current record
    $outer_data = $dbouter->getExtraData($outer_data, $where);
    if ($dbouter->errors) {
    	$errors[$dbouter->getClassName()] = $dbouter->getErrors();
    } // if

    // set variables to be included in XML output
    $scrolling[$dbouter->getClassName()]['curitem']  = $dbouter->getPageNo();
    $scrolling[$dbouter->getClassName()]['lastitem'] = $dbouter->getLastPage();
    $scrolling[$dbouter->getClassName()]['where']    = $where;
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

// obtain the required page number (optional)
if (isset($_GET['page'])) {
    $dbinner->setPageNo($_GET['page']);
} // if

// get primary key of row retrieved from OUTER entity
$pkeynames = $dbouter->getPkeyNamesAdjusted();
$where = array2where($outer_data, $pkeynames, $dbouter, false, true);

if (isset($_POST['reset'])) {
    // initialise all settings to start afresh
    $dbinner->reset($where);
} // if

if (count($outer_data) > 0) {
    if (!empty($return_from) AND !empty($popup_object)) {
        if (isset($selection) AND $popup_object == 'dbinner') {
            $inner_data = $dbinner->popupReturn($inner_data, basename($return_from), $selection, $popup_offset);
            if ($dbinner->errors) {
            	$errors[$dbinner->getClassName()] = $dbinner->getErrors();
            } // if
        } //if
    } else {
        if (empty($inner_data)) {
        	// load in current data from $outer in case it is needed
            $dbinner->setFieldArray($outer_data);
            // get data from the database
            $inner_data = $dbinner->getData($where);
        } else {
            if (!empty($dbinner->select_string)) {
                $inner_data = $dbinner->setSelectedRows($dbinner->select_string, $inner_data);
            } // if
        } // if
        if (empty($inner_data)) {
            $errors[] = getLanguageText('sys0088', strtoupper($inner_table)); // 'No entries found on $inner_table'
            //unset($act_buttons['submit']);
        } // if

        if (empty($dbinner->errors)) {
            if (!empty($inner_data)) {
                // get any additional data for current record
                $inner_data = $dbinner->getExtraData($inner_data);
            } // if
        } // if
        if ($dbinner->errors) {
        	$errors[$dbinner->getClassName()] = $dbinner->getErrors();
        } // if
    } // if
} // if

if (isset($_GET['action'])) {
    $inner_data = $dbinner->setAction($_GET['action']);
} // if

// get pagination details
$pagination['inner']['numrows']  = $dbinner->getNumRows();
$pagination['inner']['curpage']  = $dbinner->getPageNo();
$pagination['inner']['lastpage'] = $dbinner->getLastPage();

// get sort details
//$orderby     = $dbinner->getOrderBy();
//$orderby_seq = $dbinner->getOrderBySeq($orderby);

// save these variables for later in the same session
$script_vars['where']      = unqualifyWhere($where);
$script_vars['dbouter']    = serialize($dbouter);
$script_vars['dbinner']    = serialize($dbinner);
$script_vars['scrolling']  = $scrolling;
$script_vars['pagination'] = $pagination;
$script_vars = updateScriptVars ($script_vars);

// do not do this as any amendments to the screen structure file will be lost
//if ($_SERVER['REQUEST_METHOD'] == 'POST' AND empty($errors)) {
//    // repeat current task with GET instead of POST
//    scriptNext($GLOBALS['task_id'], $where);
//} // if

//if (isset($dbouter->xsl_params['outer_noedit']) AND isset($dbinner->xsl_params['inner_noedit'])) {
//    unset($act_buttons['submit']);
//    unset($act_buttons['submitnext']);
//} // if

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbouter;
$xml_objects[][$dbouter->getClassName()] = &$dbinner;

// build XML document and perform XSL transformation
$view = new radicore_view($screen_structure);
$view->buildXML($xml_objects, $errors, $messages);
exit;

?>
