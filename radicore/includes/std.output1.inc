<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.output1.inc

// type = output1

// This will output the contents a database table to a CSV file, then download
// it to the client device.

// Note that there is no dialog with the user (apart from the download box)

require_once 'include.general.inc';

// identify output mode
$mode = 'csv';

// load session variables
initSession();

//if (!empty($selection) AND !isset($return_from)) {
//    if (empty($where)) {
//    	// only use $selection if $where is empty
//        $where = $selection;
//        $selection = null;
//    } // if
//} // if

// create a class instance of the main database table
require_once "classes/$table_id.class.inc";
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

// get data from the database
$resource = $dbobject->getData_serial($where);

if ($dbobject->unbuffered_query === true) {
    // no count is available
} else {
    if (isset($stdout)) {
        $output = "<p>".$dbobject->numrows ." records read</p>\n";
        $result = fwrite($stdouth, $output);
    } // if
    if ($dbobject->getNumRows() <= 0) {
        scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
    } // if
} // if

if (!isset($csvout)) {
    // set default value
	$csvout = $table_id .'.csv';
} // if

//if (isset($csvout)) {
//	if (!$csvouth = fopen($csvout, 'w')) {
//        trigger_error("Cannot open file $csvout", E_USER_ERROR);
//    } // if
//} // if

// create an instance of the CSV object
require_once 'std.csv.class.inc';
$csv = new csv_class($dbobject);

// transform output to CSV format
$output = $csv->outputCSV($resource);
if ($csv->errors) {
    $string = format_array($csv->errors);
    display_on_stdout($string);
} // if

if (!isset($GLOBALS['batch'])) {
    // remove spinner and re-enable submit button
    setcookie('clean_up_screen_' . session_name(), $GLOBALS['task_id'], time()+30);
    // send to client browser
	header("Content-type: text/comma-separated-values");
    header('Expires: ' . gmdate('D, d M Y H:i:s') . ' GMT');
    header("Content-Disposition: attachment; filename=" .$csvout);
    header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
    header('Pragma: public');
    echo $output;
    flush();
    ob_flush();
    scriptPrevious();
} else {
    // write to disk file
    if (!empty($output) AND !empty($csvout)) {
    	if (!$result = fwrite($csvouth, $output)) {
            trigger_error("Cannot write to file $csvout", E_USER_ERROR);
        } // if
    } // if
    fclose($csvouth);
    sleep(1);
    if (!empty($csvout)) {
        $filesize = filesize($csvout);
        echo "<p>" .$filesize .' bytes written to file ' .$csvout ."</p>\n";
    } // if
    if (isset($settings['return']) AND is_True($settings['return'])) {
    	scriptPrevious($dbobject->getErrors());
    } else {
        unset($_SESSION['pages'][getSelf()]);       // delete current script's parameters from session array
        unset($_SESSION['page_stack'][$task_id]);   // delete current task from page_stack
    } // if
} // if

?>
