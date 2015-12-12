<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.list1.inc

// type = list1

// This will list occurrences from a database table

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'list';

// load session variables
initSession();

if (isset($act_buttons['choose'])) {
    if ($return_action == 'insert' AND !empty($selection)) {
    	// send selection back to the previous script
        $prev_script = getPreviousScript();
        $prev_task   = getPreviousTask($prev_script);
        $_SESSION['pages'][$prev_script][$prev_task]['selection'] = $selection;
        scriptPrevious(null, null, 'choose');
    } // if
} // if

//if (!empty($selection) AND !isset($return_from)) {
//    // $selection takes precedence over $where
//    $where     = $selection;
//    $selection = null;
//} // if

if (isset($_POST['quit'])) {
    // the 'quit' button has been pressed, so ...
    // clear this script from session details and return to previous page
    if (isset($act_buttons) AND array_key_exists('choose', $act_buttons)) {
        // 'Nothing selected from popup screen'
        scriptPrevious(getLanguageText('sys0083'),null,'quit');
    } else {
        scriptPrevious();
    } // if
} // if

// define action buttons
$act_buttons['reset'] = 'reset';
$act_buttons['quit']  = 'close';
if (array_key_exists('select_one', $settings)) {
	if (!is_True($settings['select_one'])) {
	    // this option is not valid with multiple selections
    	unset($act_buttons['choosenull']);
    } // if
} // if

// create a class instance of the main database table
require_once "classes/$table_id.class.inc";
if (isset($script_vars['dbobject'])) {
    // use data from previous instance of this script
    $dbobject = unserialize($script_vars['dbobject']);
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $dbobject->restart($return_from, $return_action, $return_string);
    } // if
    // get data from previous instance
    $fieldarray = $dbobject->getFieldArray();
    // redo any configuration changes
    $fieldarray = $dbobject->getExtraData($fieldarray);
} else {
    // create new instance for initial activation of this script
    $dbobject = new $table_id;
    // indicate that this object was started from a page controller
    $dbobject->initiated_from_controller = true;
    $dbobject->zone                      = 'main';
    $dbobject->sql_select  = &$sql_select;
    $dbobject->sql_from    = &$sql_from;
    $dbobject->sql_where   = &$sql_where;
    $dbobject->sql_groupby = &$sql_groupby;
    $dbobject->sql_having  = &$sql_having;
    $dbobject->sql_search_table = &$sql_search_table;
    if (!empty($sql_orderby)) {
        $dbobject->setDefaultOrderby($sql_orderby);
    } elseif (isset($task_orderby)) {
        $dbobject->setDefaultOrderby($task_orderby);
    } // if
    // perform any initialisation
    $where = $dbobject->initialise($where, $selection);
} // if

// the 'choose' button should only be used in popup screens
if (isset($_POST['choose']) or isset($_POST['choosenull'])) {
    list($choose_errors, $messages) = chooseButton($_POST, $dbobject, 'dbobject');
    if (!empty($choose_errors)) {
        $errors[$dbobject->getClassName()] = $choose_errors;
    } // if

} elseif (isset($_POST['reset'])) {
    // initialise all settings to start afresh
    $where = $dbobject->reset($where);

} elseif (!empty($_POST)) {
    if ($task_button = check_task_button($_POST)) {
        // look for an action which is another script
        $child_errors = childForm($_POST, array('dbobject' => $dbobject), $task_button);
        if (is_array($child_errors)) {
            $errors = array_merge($errors, $child_errors);
        } // if
    } // if
} // if

if (isset($_SESSION['rowsperpage'])) {
    $dbobject->setRowsPerPage($_SESSION['rowsperpage']);
} // if

if (isset($_GET['pagesize'])) {
    $dbobject->setRowsPerPage($_GET['pagesize']);
    $_SESSION['rowsperpage'] = $_GET['pagesize'];
} // if

// obtain the required page number (optional)
if (isset($_GET['page'])) {
    $dbobject->setPageNo($_GET['page']);
} // if

// obtain the 'orderby' field (optional)
if (isset($_GET['orderby'])) {
    $string = validateSortItem('main', $_GET['orderby'], $dbobject, $screen_structure);
    $dbobject->setOrderBy($string, $dbobject->sql_orderby_seq);
} // if

// look for optional search criteria
if (isset($quicksearch)) {
    // from quicksearch area in list screen
    $dbobject->setSqlQuickSearch($quicksearch, true);
} elseif (isset($search)) {
    // from search screen
    $dbobject->setSqlSearch($search, true);
} // if

if (isset($instruction)) {
    // load instruction returned by a child script
    $dbobject->setInstruction($instruction);
} // if

// get data from the database
$fieldarray = $dbobject->getData($where);
if ($dbobject->errors) {
	$prev_script = getPreviousScript();
    $prev_task   = getPreviousTask($prev_script);
    // send selection back to the previous script
    $_SESSION['pages'][$prev_script][$prev_task]['selection'] = 'NULL=NULL';
    scriptPrevious($dbobject->getErrors());
} else {
    // get any data for lookup lists
    $fieldarray = $dbobject->getExtraData($fieldarray, $where);
    if (!empty($dbobject->errors)) {
    	$errors = array_merge($errors, $dbobject->getErrors());
    } // if
} // if

if ($dbobject->getNumRows() == 0) {
    $messages[] = getLanguageText('sys0089'); // 'Nothing was found matching this profile'
    if (strtolower($return_action) == 'search') {
        if (isset($return_from)) {
            // go back to script which generated this profile
            scriptNext($return_from, $where);
        } // if
    } // if
    if (array_key_exists('choose', $act_buttons)) {
        // this is unusable, so remove it
        unset($act_buttons['choose']);
    } // if
} // if

// check for only one row being found in POPUP mode
if ($dbobject->getNumRows() == 1 AND isset($act_buttons['choose'])) {
    if (array_key_exists('choose_single_row', $settings)) {
        $prev_script = getPreviousScript();
        $prev_task   = getPreviousTask($prev_script);
        // convert selection into SQL where format
        $pkey_array = $dbobject->getPkeyArray($fieldarray, $prev_task);
        $selection = array2where($pkey_array);
        // send selection back to the previous script
        $_SESSION['pages'][$prev_script][$prev_task]['selection'] = $selection;
        scriptPrevious($errors, $messages, 'choose');
    } // if
} // if

if (!empty($dbobject->messages)) {
	$messages = array_merge($messages, $dbobject->getMessages);
} // if

if (isset($_GET['action'])) {
    $fieldarray = $dbobject->setAction($_GET['action']);
} // if

// get pagination details
$pagination['main']['numrows']  = $dbobject->getNumRows();
$pagination['main']['curpage']  = $dbobject->getPageNo();
$pagination['main']['lastpage'] = $dbobject->getLastPage();

// get sort details
//$orderby     = $dbobject->getOrderBy();
//$orderby_seq = $dbobject->getOrderBySeq($orderby);

// save these variables for later in the same session
$script_vars['where']    = $where;
$script_vars['dbobject'] = serialize($dbobject);
$script_vars = updateScriptVars ($script_vars);

$dbobject->fieldarray = $fieldarray;  // replace data lost during serialization

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbobject;

// build XML document and perform XSL transformation
$view = new radicore_view($screen_structure);
$view->buildXML($xml_objects, $errors, $messages);
exit;

?>
