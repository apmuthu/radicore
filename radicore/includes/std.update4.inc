<?php
// *****************************************************************************
// Copyright 2003-2005 by A J Marston <http://www.tonymarston.net>
// Copyright 2006 by Radicore Software Limited <http://www.radicore.org>
// *****************************************************************************

// name = std.update4.inc

// type = update4

// This will allow one or more database rows to be updated without being displayed.
// The contents of $where (optional) is passed down from the previous screen.
// NOTE: There is no dialog with the user.

require_once 'include.general.inc';

// identify mode for xsl file
$mode = 'update';

// load session variables
initSession();

// create a class instance for the main database table
require_once "classes/$table_id.class.inc";
$dbobject = new $table_id;
$dbobject->sql_select  = &$sql_select;
$dbobject->sql_from    = &$sql_from;
$dbobject->sql_where   = &$sql_where;
$dbobject->sql_groupby = &$sql_groupby;
$dbobject->sql_having  = &$sql_having;

// retrieve profile must have been set by previous screen
if (!empty($selection)) {
    $where     = $selection;
    $selection = null;
} // if
if (empty($where)) {
    scriptPrevious(getLanguageText('sys0081')); // 'Nothing has been selected yet.'
} // if

// get data from the database
$fieldarray = $dbobject->getData($where);
if ($dbobject->getErrors()) {
    // some sort of error - return to previous script
    scriptprevious($dbobject->getErrors(), $messages, null, $dbobject->getInstruction());
} // if
if ($dbobject->getNumRows() < 1) {
    scriptPrevious(getLanguageText('sys0085')); // 'Nothing retrieved from the database.'
} // if

$messages = $dbobject->getMessages();

// update this data in the database
$post = array();
$dbobject->startTransaction();
$fieldarray = $dbobject->updateMultiple($fieldarray, $post);
if ($dbobject->errors) {
    $dbobject->rollback();
    $errors = $dbobject->getErrors();
} else {
    $errors = $dbobject->commit();
} // if

scriptPrevious($errors, $messages, null, $dbobject->getInstruction());
exit;

?>
