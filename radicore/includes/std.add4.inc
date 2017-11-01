<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.add4.inc

// type = add4

// This will allow one or more database rows to be created.
// The contents of $where (optional) is passed down from the previous screen.
// Note that there is no dialog with the user.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'insert';

// load session variables
initSession();

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

$dbobject->sql_select  = &$sql_select;
$dbobject->sql_from    = &$sql_from;
$dbobject->sql_where   = &$sql_where;
$dbobject->sql_groupby = &$sql_groupby;
$dbobject->sql_having  = &$sql_having;

if (!empty($return_from)) {
    // see if any action is required when being restarted
    $dbobject->restart($return_from, $return_action, $return_string, $return_files);
} // if

// get initial data for new record(s)
$where = $dbobject->initialise($where, $selection);
if (empty($dbobject->errors)) {
    //$where_array = where2array($where);
	//$fieldarray = $dbobject->getInitialDataMultiple($where_array);
    $fieldarray = $dbobject->getInitialDataMultiple($where);
} // if
if (!empty($dbobject->messages)) {
	$messages = array_merge($messages, $dbobject->getMessages());
} // if
if ($dbobject->errors) {
    // error detected, so quit now
    $batch_errors = scriptPrevious($dbobject->getErrors(), $messages, 'fail');
    return $batch_errors;
} // if

// add record(s) to the database
$dbobject->startTransaction();
$fieldarray = $dbobject->insertMultiple($fieldarray);
$errors   = $dbobject->getErrors();
if ($errors) {
    $dbobject->rollback();
} else {
    $messages = array_merge($messages, $dbobject->getMessages());
    $errors = $dbobject->commit();
} // if

if (empty($errors)) {
	$action = 'insert';
} else {
    $action = 'fail';
} // if

$batch_errors = scriptPrevious($errors, $messages, $action);
return $batch_errors;

?>
