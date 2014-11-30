<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.output5.inc

// type = output5

// This will output the contents a database table to a PDF file (LABEL view)
// then download it to the client device.

// Note that there is no dialog with the user (apart from the download box)

require_once 'include.general.inc';

// identify output mode
$mode = 'pdf-label';

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
	scriptPrevious($dbobject->getErrors());
} // if

if ($dbobject->getNumRows() == 0) {
    scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
} // if

if (empty($pdfout)) {
    // set default value
	$pdfout = $table_id .'.pdf';
} // if

// create an instance of the PDF object
require_once 'std.pdf.class.inc';
$pdf = new PDF($report_structure, $dbobject, $pdfout);

// transform output to PDF format and deal with it as specified in $report
$document = $pdf->outputPDF_LabelView($resource);

$destination = $dbobject->pdf_destination;
$messages    = $dbobject->getMessages();
$errors      = $dbobject->getErrors();

$prev_script = getPreviousScript($task_id);
$prev_task   = getPreviousTask($prev_script);
// tell previous script that we are returning
$_SESSION['pages'][$prev_script][$prev_task]['return_from'] = 'pdf';

if (!preg_match('/(D|I)/i', $destination) OR !empty($errors)) {
	scriptPrevious($errors, $messages, 'OK');
} else {
    unset($_SESSION['pages'][getSelf()]);  // delete current script from session array
} // if

exit;
?>
