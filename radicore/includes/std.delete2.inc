<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.delete2.inc

// type = delete2

// This will delete a selection of occurrences as identified in $where
// (as supplied from the previous screen).
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
    // convert selection from SQL 'where' format into an array
    $fieldarray = splitWhereByRow($selection);

    $dbobject->startTransaction();

    $fieldarray = $dbobject->deleteMultiple($fieldarray);
    $errors = $dbobject->getErrors();
    if (!$errors) {
        $errors = $dbobject->commit();
    } // if
    if ($errors) {
        $dbobject->rollback();
    } // if

    $messages = array_merge($messages, $dbobject->getMessages());

    // return to previous screen
    scriptPrevious($errors, $messages);
} // if

?>
