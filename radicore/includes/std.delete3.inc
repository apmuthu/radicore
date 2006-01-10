<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
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

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    // retrieve profile must have been set by previous screen
    if (empty($selection)) {
        scriptPrevious(getLanguageText('sys0081')); // 'Nothing has been selected yet.'
    } // if

    $dbobject->startTransaction();

    // pass details to database object
    $messages = $dbobject->deleteSelection($selection);
    $errors   = $dbobject->getErrors();

    if (!$errors) {
        $errors = $dbobject->commit();
    } // if
    if ($errors) {
        $dbobject->rollback();
    } // if

    // return to previous screen
    scriptPrevious($errors, $messages);
} // if

?>
