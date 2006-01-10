<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.link1.inc

// type = link1

// This deals with a MANY-to-MANY relationship by using an intermediate LINK table
// to provide a MANY-to-LINK-to-MANY structure. Each MANY-to-LINK relationship can
// now be treated as a standard ONE-to-MANY relationship.
// This version allows only one occurrence of LINK to exist for a combination of
// MANY(outer) and MANY(inner). The existence of an occurrence is treated as 'YES'
// while the non-existence of an occurrence is treated as 'NO'.
// A single occurrence of MANY(outer) must be selected, after which all available
// occurrence of MANY(inner) will be shown with a checkbox to signify if an occurrence
// of the LINK table exists or not.
// All the user has to do to add or delete occurrences of the LINK table is to toggle
// the setting of each checkbox.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'update';

// load session variables
initSession();

if (isset($_POST['quit'])) {
    // close this screen, return to previous screen
    scriptPrevious(null, null, 'quit');
} // if

// define action buttons
$act_buttons['reset']  = 'reset';
$act_buttons['submit'] = 'submit';
$act_buttons['quit']   = 'cancel';

// create a class instance for the OUTER database table
require_once "classes/$outer_table.class.inc";
if (isset($script_vars['dbouter'])) {
    // use data from previous instance of this script
    $dbouter = unserialize($script_vars['dbouter']);
    // get previously retrieved data
    $outer_data = $dbouter->getFieldArray();
} else {
    // create new instance for initial activation of this script
    $dbouter = new $outer_table;
    $dbouter->sql_select  = &$outer_sql_select;
    $dbouter->sql_from    = &$outer_sql_from;
    $dbouter->sql_where   = &$outer_sql_where;
    $dbouter->sql_groupby = &$outer_sql_groupby;
    $dbouter->sql_having  = &$outer_sql_having;
    if (!empty($order_by)) {
        $dbouter->setOrderby($order_by);
        if (!empty($order_by_seq)) {
            $dbouter->setOrderBySeq($order_by_seq);
        } // if
    } // if
    // check that primary key is complete
    $dbouter->checkPrimaryKey = true;
    // scroll through one item at a time
    $dbouter->setRowsPerPage(1);
} // if

// create a class instance for the LINK database table
require_once "classes/$link_table.class.inc";
if (isset($script_vars['dblink'])) {
    // use data from previous instance of this script
    $dblink = unserialize($script_vars['dblink']);
} else {
    // create new instance for initial activation of this script
    $dblink = new $link_table;
    $dblink->sql_select       = &$link_sql_select;
    $dblink->sql_from         = &$link_sql_from;
    $dblink->sql_where        = &$link_sql_where;
    $dblink->sql_groupby      = &$link_sql_groupby;
    $dblink->sql_having       = &$link_sql_having;
    if (!empty($order_by_body)) {
        $dblink->setDefaultOrderby($order_by_body);
    } // if
    $dblink->sql_search_table = &$link_search_table;

    // these are used to signify an outer-link-inner relationship
    $dblink->outer_table    = $outer_table;
    $dblink->inner_table    = $inner_table;
    $dblink->is_link_table  = TRUE;

    // get any extra data (such as lookup lists)
    $null = $dblink->getExtraData(null);
} // if

if (!empty($_POST)) {
    // look for an action which is another script
    $errors = childForm($_POST, $dblink, 'dblink', $where);
} // if

// look for entered data
if (isset($_POST['submit'])) {
    // get original data from session details
    $link_data = $dblink->getFieldArray();
    // update this data in the database
    $dblink->startTransaction();
    $link_data = $dblink->updateLinkData($link_data, $_POST);
    if ($dblink->errors) {
        $dblink->rollback();
		// errors are keyed by object name
        $errors[$dblink->getClassName()] = $dblink->getErrors();
    } else {
        // update was OK
        $errors = $dblink->commit();
        if (empty($errors)) {
            $messages[] = getLanguageText('sys0091'); // 'Update successful'
        } // if
    } // if
} // if

if (!empty($selection)) {
    // retrieve profile has been passed down from previous screen
    $where     = $selection;
    $selection = null;
} else {
    if (isset($scrolling)) {
        // retrieve values from scrolling array
        $where = $scrolling[$dbouter->getClassName()]['where'];
        $dbouter->setPageNo($scrolling[$dbouter->getClassName()]['curitem']);
    } // if
} // if

if (empty($where)) {
    scriptPrevious(getLanguageText('sys0082')); // 'No parent has been selected yet.'
} // if

if (isset($_GET['scrolling']) AND $_GET['scrolling'] == $dbouter->getClassName()) {
    // set index number of item to be read from current $where list
    $dbouter->setPageNo($_GET['item']);
} // if

// get data from the outer table
$outer_data = $dbouter->getData($where);
if ($dbouter->errors) {
    // some sort of error - return to previous script
    scriptprevious($dbouter->getErrors(), $messages);
} // if
if ($dbouter->getNumRows() < 1) {
    scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
} // if

// set variables to be included in XML output
$scrolling[$dbouter->getClassName()]['curitem']  = $dbouter->getPageNo();
$scrolling[$dbouter->getClassName()]['lastitem'] = $dbouter->getLastPage();
$scrolling[$dbouter->getClassName()]['where']    = $where;

// get any extra data and merge with $outer_data
$outer_data = $dbouter->getExtraData($outer_data);

if (isset($_SESSION['rowsperpage'])) {
    $dblink->setRowsPerPage($_SESSION['rowsperpage']);
} // if

if (isset($_GET['pagesize'])) {
    $dblink->setRowsPerPage($_GET['pagesize']);
    $_SESSION['rowsperpage'] = $_GET['pagesize'];
} // if

// obtain the required page number (optional)
if (isset($_GET['page'])) {
    $dblink->setPageNo($_GET['page']);
} // if

// obtain the 'orderby' field (optional)
if (isset($_GET['orderby'])) {
    if (isset($screen)) {
    	if (validateSortItem('link', $_GET['orderby'], $screen)) {
        	$dblink->setOrderBy($_GET['orderby']);
        } // if
    } else {
        $dblink->setOrderBy($_GET['orderby']);
    } // if
} // if

// load optional criteria from search screen
if (isset($search)) {
    $dblink->setSqlSearch($search);
} // if

if (isset($_POST['reset'])) {
    // initialise all settings to start afresh
    $dblink->setPageNo(null);
    $dblink->setOrderBy(null);
    $dblink->setOrderBySeq(null);
    $dblink->setSqlSearch(null);
} // if

// get primary key of row retrieved from OUTER entity
$where = array2where($outer_data, $dbouter->getPkeyNames(), $dbouter);

// ensure that column names are qualified in the 'where' clause
$link_where = qualifyWhere($where, $dbouter->tablename, $dbouter->getFieldSpec());

//if ($_SERVER['REQUEST_METHOD'] == 'GET' OR isset($_POST['reset'])) {
if (empty($errors)) {
    // get data from the database
    $link_data = $dblink->getData($link_where);

    if ($dblink->getErrors()) {
        $errors = array_merge($errors, $dblink->getErrors());
    } // if

    if ($dblink->getNumRows() == 0) {
        $errors[] = getLanguageText('sys0088', $link_table); // "No entries found on $link_table"
        unset($act_buttons['submit']);
    } // if

} else {
    // use saved array as data for link entity
    $link_data = $dblink->getFieldArray();
} // if

if (isset($_GET['action'])) {
    $fieldarray = $dblink->setAction($_GET['action']);
} // if

// get pagination details
$pagination['link']['numrows']  = $dblink->getNumRows();
$pagination['link']['curpage']  = $dblink->getPageNo();
$pagination['link']['lastpage'] = $dblink->getLastPage();

// ensure script variables are available throughout this session
unset($script_vars['selection']);
$script_vars['where']     = $where;
$script_vars['dbouter']   = serialize($dbouter);
$script_vars['dblink']    = serialize($dblink);
$script_vars['scrolling'] = $scrolling;
$PHP_SELF = getSelf();  // reduce PHP_SELF to '/dir/file.php'
$_SESSION[$PHP_SELF][$task_id] = $script_vars;

// get sort details
$orderby     = $dblink->getOrderBy();
$orderby_seq = $dblink->getOrderBySeq();

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbouter;
$xml_objects[][$dbouter->getClassName()] = &$dblink;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);
exit;

?>
