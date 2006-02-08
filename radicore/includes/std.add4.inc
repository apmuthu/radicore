<?php
// *****************************************************************************
// Copyright 2003-2006 by A J Marston <http://www.tonymarston.net>
// Licensed to Radicore Software Limited <http://www.radicore.org>
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

// create a class instance for the main database table
require_once "classes/$table_id.class.inc";
$dbobject = new $table_id;
$dbobject->sql_select  = &$sql_select;
$dbobject->sql_from    = &$sql_from;
$dbobject->sql_where   = &$sql_where;
$dbobject->sql_groupby = &$sql_groupby;
$dbobject->sql_having  = &$sql_having;

// get initial data for new record(s)
$fieldarray = $dbobject->getInitialData($where);
if ($dbobject->getErrors()) {
    // error detected, so quit now
    scriptPrevious($dbobject->getErrors(), $messages);
} // if

// add record(s) to the database
$dbobject->startTransaction();
$fieldarray = $dbobject->insertMultiple($fieldarray);
$errors = $dbobject->getErrors();
$messages = $dbobject->getMessages();
if ($errors) {
    $dbobject->rollback();
} else {
    $errors = $dbobject->commit();
} // if

scriptPrevious($errors, $messages);
exit;

?>