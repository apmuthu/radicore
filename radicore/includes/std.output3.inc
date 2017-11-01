<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.output3.inc

// type = output3

// This will output the contents a database table to a PDF file (DETAIL view)
// then download it to the client device.

// Note that there is no dialog with the user (apart from the download box)

$mode = 'pdf-detail';   // identify output mode

if (preg_match('/cli/i', php_sapi_name())) {
    // being run from the command line, so initialisation has already been done
} else {
    require_once 'include.general.inc';
    initSession();          // load session variables
} // if

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
$dbobject->sql_select  = (empty($sql_select))  ? null : $sql_select;
$dbobject->sql_from    = (empty($sql_from))    ? null : $sql_from;
$dbobject->sql_where   = (empty($sql_where))   ? null : $sql_where;
$dbobject->sql_groupby = (empty($sql_groupby)) ? null : $sql_groupby;
$dbobject->sql_having  = (empty($sql_having))  ? null : $sql_having;
if (!empty($sql_orderby)) {
    $dbobject->setDefaultOrderby($sql_orderby);
} elseif (isset($task_orderby)) {
    $dbobject->setDefaultOrderby($task_orderby);
} // if

// perform any initialisation
$where = $dbobject->initialise($where, $selection, $search);
if ($dbobject->errors) {
	$batch_errors = scriptPrevious($dbobject->getErrors());
	return $batch_errors;
} // if

// get any data for lookup lists
$null = $dbobject->getExtraData($where);

// set sort order (if defined)
if (!empty($orderby)) {
    $string = validateSortItem('body', $orderby, $dbobject, $report_structure);
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
if (!empty($dbobject->errors)) {
	$batch_errors = scriptPrevious($dbobject->getErrors());
	return $batch_errors;
} // if

if ($dbobject->getNumRows() == 0) {
    $batch_errors = scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
    return $batch_errors;
} // if

if (empty($pdfout)) {
    // set default value
	$pdfout = $table_id .'.pdf';
} // if

// create an instance of the PDF object
require_once 'std.pdf.class.inc';
$pdf = new PDF($report_structure, $dbobject, $pdfout);

// transform output to PDF format and deal with it as specified in $report
$document = $pdf->outputPDF_DetailView($resource);

$destination = $dbobject->pdf_destination;
$messages    = $dbobject->getMessages();
$errors      = $dbobject->getErrors();

$prev_script = getPreviousScript($task_id);
$prev_task   = getPreviousTask($prev_script);
if (!empty($prev_script) AND !empty($task_id)) {
    // tell previous script that we are returning
    $_SESSION['pages'][$prev_script][$prev_task]['return_from'] = 'pdf';
} // if

if (!preg_match('/(D|I)/i', $destination) OR !empty($errors) OR isset($GLOBALS['batch'])) {
	$batch_errors = scriptPrevious($errors, $messages, 'OK');
	if (isset($GLOBALS['stdouth'])) {
		foreach ($messages as $key => $message) {
			$result = fwrite($stdouth, $message);
		} // foreach
	} // if
	return $batch_errors;
} else {
    unset($_SESSION['pages'][getSelf()]);       // delete current script's parameters from session array
    unset($_SESSION['page_stack'][$task_id]);   // delete current task from page_stack
} // if

exit;
?>
