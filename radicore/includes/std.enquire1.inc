<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2008 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.enquire1.inc

// type = enquire1

// This will display a sngle selected database occurrence using $where
// (as supplied from the previous screen)

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'read';

// load session variables
initSession();

if (!empty($selection) AND (!isset($return_from) OR $return_action == 'choose')) {
    // $selection takes precedence over $where
    $where     = $selection;
    $selection = null;
    $new_selection = true;
} else{
    $new_selection = false;
} // if

// look for a button being pressed
if (isset($_POST['quit'])) {
    // cancel this screen, return to previous screen
    scriptPrevious();
} // if

// define action buttons
$act_buttons['copy'] = 'copy';
$act_buttons['quit'] = 'close';

// create a class instance for the main database table
require_once "classes/$table_id.class.inc";
if (isset($script_vars['dbobject'])) {
    // use data from previous instance for this script
    $dbobject = unserialize($script_vars['dbobject']);
    // get previous data
    $fieldarray = $dbobject->getFieldArray();
    if (!is_string(key($fieldarray))) {
        // indexed by row, so use first row only
        $fieldarray = $fieldarray[key($fieldarray)];
    } // if
} else {
    $dbobject = new $table_id;
    // indicate that this object was started from a page controller
    $dbobject->initiated_from_controller = true;
    $dbobject->sql_select  = &$sql_select;
    $dbobject->sql_from    = &$sql_from;
    $dbobject->sql_where   = &$sql_where;
    $dbobject->sql_groupby = &$sql_groupby;
    $dbobject->sql_having  = &$sql_having;
    // scroll through one item at a time
    $dbobject->setRowsPerPage(1);
    // check that primary key is complete
    $dbobject->checkPrimaryKey = true;
    // perform any initialisation
    $where = $dbobject->initialise($where);
    // set sort order (if defined)
    if (!empty($orderby)) {
        $string = validateSortItem('main', $orderby, $dbobject, $screen_structure);
        $dbobject->setOrderBy($string);
        if (!empty($orderby_seq)) {
            $dbobject->setOrderBySeq($orderby_seq);
        } // if
    } // if
} // if

if (isset($scrolling)) {
    if ($new_selection === true) {
    	// selection has changed, so use new value in $where
    	$dbobject->setPageNo(1);
    } else {
        // retrieve values from scrolling array
        $where = $scrolling[$dbobject->getClassName()]['where'];
        $dbobject->setPageNo($scrolling[$dbobject->getClassName()]['curitem']);
    } // if
} // if

if (empty($where)) {
    scriptPrevious(getLanguageText('sys0081')); // 'Nothing has been selected yet.'
} // if

if (isset($_GET['scrolling']) AND $_GET['scrolling'] == $dbobject->getClassName()) {
    // set index number of item to be read from current $where list
    $dbobject->setPageNo($_GET['item']);
} // if

// get data from the database
$fieldarray = $dbobject->getData($where);

if ($dbobject->getErrors()) {
    // some sort of error - return to previous script
    scriptprevious($dbobject->getErrors(), $messages);
} // if

// check number of rows returned
if ($dbobject->getNumRows() < 1) {
    scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
} // if

// get any extra data and merge with $fieldarray
$fieldarray = $dbobject->getExtraData($fieldarray);
if ($dbobject->errors) {
	$errors[$dbobject->getClassName()] = $dbobject->errors;
} // if

// set variables to be included in XML output
$scrolling[$dbobject->getClassName()]['curitem']  = $dbobject->getPageNo();
$scrolling[$dbobject->getClassName()]['lastitem'] = $dbobject->getLastPage();
$scrolling[$dbobject->getClassName()]['where']    = $where;

// save these variables for later in the same session
$script_vars['where']     = $where;
$script_vars['scrolling'] = $scrolling;
$script_vars['dbobject']  = serialize($dbobject);
$script_vars = updateScriptVars ($script_vars);

// rebuild selection using primary key of retrieved row
$pkeynames = $dbobject->getPkeyNamesAdjusted();
$where = array2where($fieldarray, $pkeynames, $dbobject);

if (!empty($_POST)) {
    if (isset($_POST['copy'])) {
        $messages = copyForm($_POST, $dbobject);
    } else {
        // look for an action which is another script
        $errors = childForm($_POST, array('dbobject' => $dbobject));
    } // endif
} // if

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbobject;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);
exit;

?>
