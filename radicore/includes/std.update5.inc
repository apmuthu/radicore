<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.update5.inc

// type = update5

// This will allow one or more database rows to be inserted or updated.
// The contents of $where (optional) is passed down from the previous screen.

// NOTE: There is no dialog with the user.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'update';

// load session variables
initSession();

//if (!empty($selection) AND !isset($return_from)) {
//    // $selection takes precedence over $where
//    $where     = $selection;
//    $selection = null;
//} // if

// retrieve profile must have been set by previous screen
if (empty($where) AND empty($selection)) {
    $batch_errors = scriptPrevious(getLanguageText('sys0081')); // 'Nothing has been selected yet.'
    return $batch_errors;
} // if

// create a class instance for the main database table
require_once "classes/$table_id.class.inc";
$dbobject = new $table_id;
// indicate that this object was started from a page controller
$dbobject->initiated_from_controller = true;
// perform any initialisation
$where = $dbobject->initialise($where, $selection);

if ($dbobject->messages) {
	$messages = array_merge($messages, $dbobject->getMessages());
} // if

if ($dbobject->errors) {
    // some sort of error - return to previous script
    $batch_errors = scriptPrevious($dbobject->getErrors(), $messages, 'fail', $dbobject->getInstruction());
    return $batch_errors;
} // if

// get data created in initialise()
$fieldarray = $dbobject->getFieldArray();
if (empty($fieldarray)) {
    $batch_errors = scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
    return $batch_errors;
} // if

// insert or update this data in the database
$dbobject->startTransaction();
$fieldarray = $dbobject->insertOrUpdate($fieldarray);
if ($dbobject->errors) {
    $dbobject->rollback();
    $errors = $dbobject->getErrors();
} else {
    $errors = $dbobject->commit();
} // if

if (!empty($dbobject->messages)) {
    $messages = array_merge($messages, $dbobject->getMessages());
} // if

if (empty($errors)) {
	$action = 'update';
} else {
    $action = 'fail';
} // if

$batch_errors = scriptPrevious($errors, $messages, $action, $dbobject->getInstruction());
return $batch_errors;

?>
