<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.list1.inc

// type = list1

// This will list occurrences from a database table

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'list';

// load session variables
initSession();

if (isset($_POST['quit'])) {
    // the 'quit' button has been pressed, so ...
    // clear this script from session details and return to previous page
    if (isset($act_buttons) AND array_key_exists('choose', $act_buttons)) {
        scriptPrevious(getLanguageText('sys0083')); // 'Nothing selected from popup screen.'
    } else {
        scriptPrevious();
    } // if
} // if

// define action buttons
$act_buttons['reset'] = 'reset';
if (isset($act_buttons['choose'])) {
    $act_buttons['quit'] = 'cancel';
} // if

// create a class instance of the main database table
require_once "classes/$table_id.class.inc";
if (isset($script_vars['dbobject'])) {
    // use data from previous instance of this script
    $dbobject = unserialize($script_vars['dbobject']);
    // refetch data for lookup lists in case they have changed
    $null = $dbobject->setLookupData(null);
} else {
    // create new instance for initial activation of this script
    $dbobject = new $table_id;
    $dbobject->sql_select  = &$sql_select;
    $dbobject->sql_from    = &$sql_from;
    $dbobject->sql_where   = &$sql_where;
    $dbobject->sql_groupby = &$sql_groupby;
    $dbobject->sql_having  = &$sql_having;
    if (!empty($sql_orderby)) {
        $dbobject->setDefaultOrderby($sql_orderby);
    } elseif (isset($order_by_body)) {
        $dbobject->setDefaultOrderby($order_by_body);
    } // if
    // get any data for lookup lists
    $null = $dbobject->getExtraData(null);
} // if

// the 'choose' button should only be used in popup screens
if (isset($_POST['choose'])) {
    $messages = chooseButton($_POST, $dbobject);
} // if

if (!empty($_POST)) {
    // look for an action which is another script
    $errors = childForm($_POST, $dbobject, 'dbobject', $where);
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
    if (isset($screen)) {
    	if (validateSortItem('main', $_GET['orderby'], $screen)) {
        	$dbobject->setOrderBy($_GET['orderby']);
        } // if
    } else {
        $dbobject->setOrderBy($_GET['orderby']);
    } // if
} // if

// load optional criteria from search screen
if (isset($search)) {
    $dbobject->setSqlSearch($search);
} // if

if (isset($_POST['reset'])) {
    // initialise all settings to start afresh
    $dbobject->setPageNo(null);
    $dbobject->setOrderBy(null);
    $dbobject->setOrderBySeq(null);
    $dbobject->setSqlSearch(null);
} // if

if (isset($instruction)) {
    // load instruction returned by a child script
    $dbobject->setInstruction($instruction);
} // if

if (!empty($selection)) {
    // retrieve profile has been set by previous screen
    $where     = $selection;
    $selection = null;
} // if

// get data from the database
$fieldarray = $dbobject->getData($where);

if ($dbobject->getNumRows() == 0) {
    $messages[] = getLanguageText('sys0089'); // 'Nothing was found matching this profile'
    if (strtolower($return_action) == 'ok') {
        if (isset($return_from)) {
            // go back to script which generated this profile
            scriptNext($return_from);
        } // if
    } // if
    if (array_key_exists('choose', $act_buttons)) {
        // this is unusable, so remove it
        unset($act_buttons['choose']);
    } // if
} // if

// check for only one row being found in POPUP mode
if ($dbobject->getNumRows() == 1 AND isset($act_buttons['choose'])) {
    // convert selection into SQL where format
    $selection = array2where($fieldarray, $dbobject->getPkeyNames(), $dbobject);
    // send selection back to the previous script
    $prev_script = getPreviousScript();
    $prev_task   = getPreviousTask($prev_script);
    $_SESSION[$prev_script][$prev_task]['selection'] = $selection;
    scriptPrevious(null, null, 'choose');
} // if

if (isset($_GET['action'])) {
    $fieldarray = $dbobject->setAction($_GET['action']);
} // if

// $where may have been changed in database object
$where = $dbobject->getWhere();

// ensure script variables are available throughout this session
unset($script_vars['selection']);
$script_vars['where']    = $where;
$script_vars['dbobject'] = serialize($dbobject);
$PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'
$_SESSION[$PHP_SELF][$task_id] = $script_vars;

// get pagination details
$pagination['main']['numrows']  = $dbobject->getNumRows();
$pagination['main']['curpage']  = $dbobject->getPageNo();
$pagination['main']['lastpage'] = $dbobject->getLastPage();

// get sort details
$orderby     = $dbobject->getOrderBy();
$orderby_seq = $dbobject->getOrderBySeq();

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbobject;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);
exit;

?>
