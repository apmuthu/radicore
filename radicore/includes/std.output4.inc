<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2011 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.output4.inc

// type = output4

// This will output the contents a database table to a CSV file, then download
// it to the client device.

// This will show the user which fields are available and get him to select the
// ones which are wanted, and only these will be output to the CSV file.

require_once 'include.general.inc';

$mode = 'csv';      // identify output mode

// load session variables
initSession();

//if (!empty($selection) AND !isset($return_from)) {
//    if (empty($where)) {
//    	// only use $selection if $where is empty
//        $where = $selection;
//        $selection = null;
//    } // if
//} // if

if (isset($_POST['quit'])) {
    // cancel this screen, return to previous screen
    scriptPrevious(null, null, 'quit');
} // if

// define action buttons
$act_buttons['submit']     = 'submit';
$act_buttons['quit']       = 'cancel';

// create a class instance for the main database table
require_once "classes/$table_id.class.inc";
if (isset($script_vars['dbobject'])) {
    // use data from previous instance for this script
    $dbobject = unserialize($script_vars['dbobject']);
    if (!empty($return_from)) {
        // see if any action is required when being restarted
        $dbobject->restart($return_from, $return_action);
    } // if
    // get data from previous instance
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
    if (!empty($sql_orderby)) {
        $dbobject->setDefaultOrderby($sql_orderby);
    } elseif (isset($task_orderby)) {
        $dbobject->setDefaultOrderby($task_orderby);
    } // if

    // perform any initialisation
    $where = $dbobject->initialise($where, $selection, $search);
    if ($dbobject->errors) {
       	scriptPrevious($dbobject->getErrors());
    } // if

    // get any data for lookup lists
    $null = $dbobject->getExtraData($where);

    // set sort order (if defined)
    if (!empty($orderby)) {
        $string = validateSortItem('', $orderby, $dbobject);
        $dbobject->setOrderBy($string);
        if (!empty($orderby_seq)) {
            $dbobject->setOrderBySeq($orderby_seq);
        } // if
    } // if

    // load optional criteria from search screen
    if (isset($search)) {
        $dbobject->setSqlSearch($search);
    } // if
} // if

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    // reset original field specifications
    $dbobject->fieldspec = $dbobject->getFieldspec_original();
    $fieldarray = $dbobject->_cm_changeConfig ($where, $fieldarray);

    // look for LIMIT and OFFSET values
    $rdc_limit  =& $_POST['rdc_limit'];
    $rdc_offset =& $_POST['rdc_offset'];

    // get data from the database
    $resource = $dbobject->getData_serial($where, $rdc_limit, $rdc_offset);

    if ($dbobject->getNumRows() <= 0) {
        scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
    } // if

    if (empty($csvout)) {
        // set default value
    	$csvout = $table_id .'.csv';
    } // if

    // transform output to CSV format
    $output = $dbobject->outputCSV($resource, $_POST);
    $errors = $dbobject->getErrors();
    $messages = $dbobject->getMessages();

    if (!empty($output)) {
    	// download to client browser
        header("Content-type: text/comma-separated-values");
        header('Expires: ' . gmdate('D, d M Y H:i:s') . ' GMT');
        header("Content-Disposition: attachment; filename=" .$csvout);
        header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
        header('Pragma: public');
        echo $output;
    } // if
    //unset($_SESSION['pages'][getSelf()]);
    //scriptPrevious($errors, $messages);
    exit;
} // if

$mode = 'update';      // identify mode for building the screen

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $fieldarray = $dbobject->getColumnNames($where);
} // if

// save these variables for later in the same session
$script_vars['where']     = $where;
$script_vars['dbobject']  = serialize($dbobject);
$script_vars['scrolling'] = $scrolling;
$script_vars = updateScriptVars ($script_vars);

// build list of objects for output to XML data
$xml_objects[]['root'] = &$dbobject;

// build XML document and perform XSL transformation
buildXML($xml_objects, $errors, $messages);

exit;
?>
