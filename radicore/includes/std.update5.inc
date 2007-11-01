<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2007 by Radicore Software Limited <http://www.radicore.org>
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

if (!empty($selection) AND !isset($return_from)) {
    // $selection takes precedence over $where
    $where     = $selection;
    $selection = null;
} // if

// retrieve profile must have been set by previous screen
if (empty($where)) {
    $batch_errors = scriptPrevious(getLanguageText('sys0081')); // 'Nothing has been selected yet.'
    return $batch_errors;
} // if

// create a class instance for the main database table
require_once "classes/$table_id.class.inc";
$dbobject = new $table_id;
// perform any initialisation
$where = $dbobject->initialise($where);

if ($dbobject->errors) {
    // some sort of error - return to previous script
    $batch_errors = scriptPrevious($dbobject->errors, $messages, null, $dbobject->getInstruction());
    return $batch_errors;
} // if

// get data created in initialise()
$fieldarray = $dbobject->getFieldArray();
if (count($fieldarray) < 1) {
    $batch_errors = scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
    return $batch_errors;
} // if

$messages = $dbobject->messages;

// insert or update this data in the database
$dbobject->startTransaction();
$fieldarray = $dbobject->insertOrUpdate($fieldarray);
if ($dbobject->errors) {
    $dbobject->rollback();
    $errors = $dbobject->errors;
} else {
    $errors = $dbobject->commit();
    if (empty($messages)) {
    	$messages = $dbobject->messages;
    } // if
} // if

$batch_errors = scriptPrevious($errors, $messages, null, $dbobject->getInstruction());
return $batch_errors;

?>
