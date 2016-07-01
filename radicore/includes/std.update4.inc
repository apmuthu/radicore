<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2016 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.update4.inc

// type = update4

// This will allow one or more database rows to be updated without being displayed.
// The contents of $where (optional) is passed down from the previous screen.

// NOTE: There is no dialog with the user.

if (preg_match('/cli/i', php_sapi_name())) {
    // being run from the command line, so initialisation has already been done
} else {
    require_once 'include.general.inc';
    initSession();      // load session variables
} // if

$mode = 'update';   // identify mode for xsl file

//if (!empty($selection) AND !isset($return_from)) {
//    // $selection takes precedence over $where
//    $where     = $selection;
//    $selection = null;
//} // if

// create a class instance for the main database table
require_once "classes/$table_id.class.inc";
$dbobject = new $table_id;
// indicate that this object was started from a page controller
$dbobject->initiated_from_controller = true;
$dbobject->sql_select  = (empty($sql_select))  ? null : $sql_select;
$dbobject->sql_from    = (empty($sql_from))    ? null : $sql_from;
$dbobject->sql_where   = (empty($sql_where))   ? null : $sql_where;
$dbobject->sql_groupby = (empty($sql_groupby)) ? null : $sql_groupby;
$dbobject->sql_having  = (empty($sql_having))  ? null : $sql_having;
if (!empty($orderby)) {
    $string = validateSortItem('main', $orderby, $dbobject);
    $dbobject->setOrderBy($string);
    if (!empty($orderby_seq)) {
        $dbobject->setOrderBySeq($orderby_seq);
    } // if
} // if
// perform any initialisation
$where = $dbobject->initialise($where, $selection);
if ($dbobject->errors) {
    $batch_errors = scriptPrevious($dbobject->getErrors());
    return $batch_errors;
} // if

// retrieve profile must have been set by previous screen
if (empty($where) AND !is_True($dbobject->allow_empty_where)) {
    $batch_errors = scriptPrevious(getLanguageText('sys0081')); // 'Nothing has been selected yet.'
    return $batch_errors;
} // if

// get data from the database
$fieldarray = $dbobject->getData($where);
if ($dbobject->errors) {
    // some sort of error - return to previous script
    $batch_errors = scriptPrevious($dbobject->getErrors(), $messages, 'fail', $dbobject->getInstruction());
    return $batch_errors;
} // if
if ($dbobject->getNumRows() < 1) {
    $batch_errors = scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
    return $batch_errors;
} // if

$messages = array_merge($messages, $dbobject->getMessages());

// update this data in the database
$post = array();
$dbobject->startTransaction();
$fieldarray = $dbobject->updateMultiple($fieldarray, $post);

if (!isset($GLOBALS['batch']) OR isset($GLOBALS['do_commit'])) {
    if ($dbobject->errors) {
        $dbobject->rollback();
        $errors = $dbobject->getErrors();
    } else {
        $errors = $dbobject->commit();
        $messages = array_merge($messages, $dbobject->getMessages());
    } // if

    global $stdout, $stdouth;
    if (!empty($stdout)) {
	    foreach ($messages as $message) {
		    $result = fwrite($stdouth, "<p>$message</p>\n");
	    } // foreach
    } // if
} // if

if (empty($errors)) {
    $action = 'update';
} else {
    $action = 'fail';
} // if

$batch_errors = scriptPrevious($errors, $messages, $action, $dbobject->getInstruction());
return $batch_errors;

?>
