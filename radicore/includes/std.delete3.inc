<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006-2014 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.delete3.inc

// type = delete3

// This will update/delete selected records in the database using data in $where
// (supplied by the previous screen)
// NOTE: this uses a custom method 'deleteMultiple' for its processing.
// Note that there is no dialog with the user.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'delete';

// load session variables
initSession();

// create a class instance for the main database table
require_once "classes/$table_id.class.inc";
$dbobject = new $table_id;
// indicate that this object was started from a page controller
$dbobject->initiated_from_controller = true;
// perform any initialisation
$where = $dbobject->initialise ($where, $selection);

// retrieve profile must have been set by previous screen
if (empty($selection) AND empty($where)) {
    // 'Nothing has been selected yet.'
    $batch_errors = scriptPrevious(getLanguageText('sys0081'));
    return $batch_errors;
} // if

$dbobject->startTransaction();

// pass details to database object
if (!empty($selection)) {
    $messages = $dbobject->deleteSelection($selection);
} elseif (!empty($where)) {
    $messages = $dbobject->deleteSelection($where);
} // if
$errors = $dbobject->getErrors();

if (!$errors) {
    $errors = $dbobject->commit();
} // if
if ($errors) {
    $dbobject->rollback();
} // if

global $stdout, $stdouth;
if (!empty($stdout)) {
    if (!empty($messages)){
        if (is_array($messages)) {
            foreach ($messages as $message) {
                $result = fwrite($stdouth, "<p>$message</p>\n");
            } // foreach
        } else {
            $result = fwrite($stdouth, "<p>$messages</p>\n");
        } // if
    } // if
} // if

if (empty($errors)) {
    $action = 'OK';
} else {
    $action = null;
} // if

// return to previous screen
$batch_errors = scriptPrevious($errors, $messages, $action);
return $batch_errors;

?>
